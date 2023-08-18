import yaml
import binascii
import os
import sys
import numpy as np

TS_REPO_ROOT = os.environ["TS_REPO_ROOT"]
OPS_CONFIG = TS_REPO_ROOT+"/spect_ops_config.yml"

Ed25519_ID = 0x02
P256_ID = 0x01

RAR_STACK_DEPTH = 5
DATA_RAM_IN_DEPTH = 512
DATA_RAM_OUT_DEPTH = 128

SHA_CTX_INIT = binascii.unhexlify("6a09e667f3bcc908bb67ae8584caa73b3c6ef372fe94f82ba54ff53a5f1d36f1510e527fade682d19b05688c2b3e6c1f1f83d9abfb41bd6b5be0cd19137e2179")

insrc_arr = [0x0, 0x4]
outsrc_arr = [0x1, 0x5]

fw_parity = 2

def print_passed():
    print("\033[92m{}\033[00m".format("PASSED"))

def print_failed():
    print("\033[91m{}\033[00m".format("FAILED"))

def print_run_name(run_name: str):
    print("\033[94m{}\033[00m".format(f"running {run_name}"))

def find_in_list (name: str, l: list) -> dict:
    for item in l:
        if item["name"] == name:
            return item
    return None

def str2int32 (in_str: str) -> list:
    r = []
    for w in range(0, len(in_str), 8):
        w_str = in_str[w:w+8]
        r.append(int.from_bytes(binascii.unhexlify(w_str), 'little'))
    return r

def get_ops_config():
    with open(OPS_CONFIG, 'r') as ca_file:
        ops_cfg = yaml.safe_load(ca_file)
    return ops_cfg

def make_test_dir(test_name):
    test_dir = TS_REPO_ROOT+"/tests/test_"+test_name
    os.system(f"rm -rf {test_dir}")
    os.system(f"mkdir {test_dir}")
    return test_dir

def get_cmd_file(test_dir):
    cmd_file = open(test_dir+"/iss_cmd", 'w')
    return cmd_file

def start(cmd_file):
    cmd_file.write("start\n")

def run(cmd_file):
    cmd_file.write("run\n")

def exit(cmd_file):
    cmd_file.write("exit\n")

def set_cfg_word(cmd_file, cfg_word):
    cmd_file.write("set mem[0x0100] 0x{}\n".format(format(cfg_word, '08X')))

def get_res_word(test_dir, run_name):
    res_word = read_output(test_dir, run_name, 0x1100, 1)
    SPECT_OP_STATUS = res_word & 0xFF
    SPECT_OP_DATA_OUT_SIZE = (res_word >> 16) & 0xFF
    return SPECT_OP_STATUS, SPECT_OP_DATA_OUT_SIZE

def parse_context(test_dir, run_name):
    ctx_file = f"{test_dir}/{run_name}.ctx"
    ctx_dict = {
        "GPR"           : [],
        "SHA"           : b'',
        "TMAC"          : b'',
        "RAR STACK"     : [],
        "RAR POINTER"   : 0,
        "FLAGS"         : {"Z" : 0, "C" : 0, "E" : 0},
        "DATA RAM IN"   : [],
        "DATA RAM OUT"  : []
    }

    with open(ctx_file, 'r') as ctx:
        data = ctx.read().split('\n')
        for i in range(len(data)):
            line = data[i]
            if not line:
                continue
            if line[0] == "*":
                continue
            
            if line == "GPR registers:":
                i += 1  # skip next "**..**" line
                for j in range(32):
                    i += 1
                    line = data[i]
                    r = int.from_bytes(binascii.unhexlify(line), 'big')
                    ctx_dict["GPR"].append(r)
            
            if line == "SHA 512 context:":
                i += 1  # skip next "**..**" line
                for j in range(8):
                    i += 1
                    line = data[i]
                    ctx_dict["SHA"] += binascii.unhexlify(line)
                continue
                
            if line[:4] == "TMAC":
                i += 1
                for j in range(5):
                    i += 1
                    line = data[i]
                    ctx_dict["TMAC"] += binascii.unhexlify(line)
                i += 3  # skip rate, byteIOIndex and squeezing
                continue
            
            if line == "RAR stack:":
                i += 1  # skip next "**..**" line
                for j in range(RAR_STACK_DEPTH):
                    i +=1
                    line = data[i]
                    val = int.from_bytes(binascii.unhexlify(line), 'big')
                    ctx_dict["RAR STACK"].append(val)
                continue
            if line == "RAR stack pointer:":
                i += 2
                line = data[i]
                ctx_dict["RAR POINTER"] = int.from_bytes(binascii.unhexlify(line), 'big')
                continue

            if line == "FLAGS (Z, C, E):":
                i += 2
                line = data[i]
                ctx_dict["FLAGS"]["Z"] = int(line)
                i += 1
                line = data[i]
                ctx_dict["FLAGS"]["C"] = int(line)
                i += 1
                line = data[i]
                ctx_dict["FLAGS"]["E"] = int(line)
                continue

            if line == "Data RAM In:":
                i += 1
                for j in range(DATA_RAM_IN_DEPTH):
                    i += 1
                    line = data[i]
                    val = int.from_bytes(binascii.unhexlify(line), 'big')
                    ctx_dict["DATA RAM IN"].append(val)

            if line == "Data RAM Out:":
                i += 1
                for j in range(DATA_RAM_OUT_DEPTH):
                    i += 1
                    line = data[i]
                    val = int.from_bytes(binascii.unhexlify(line), 'big')
                    ctx_dict["DATA RAM OUT"].append(val)

    return ctx_dict

def parse_key_mem(test_dir, run_name):
    kmem_file = f"{test_dir}/{run_name}_keymem.hex"
    kmem_array = np.empty(shape=(16, 256, 256), dtype='uint32')
    kmem_slots = np.empty(shape=(16, 256), dtype='bool')
    with open(kmem_file, 'r') as km_file:
        data = km_file.read().split('\n')
        ktype = 0
        slot = 0
        offset = 0
        for line in data[3:]:
            if not line:
                continue
            if line[0] == '*':
                continue
            if line[0] == 'T':
                ls = line.split(' ')
                ktype = int(ls[1])
                slot = int(ls[3])
                offset = 0
                continue
            if line[0] == 'S':
                ls = line.split(' ')
                if ls[1] == "FULL":
                    kmem_slots[ktype][slot] = True
                else:
                    kmem_slots[ktype][slot] = False
                continue
            d = int.from_bytes(binascii.unhexlify(line), 'big')
            kmem_array[ktype][slot][offset] = d
            offset += 1
    return kmem_array, kmem_slots

def set_key(cmd_file, key, ktype, slot, offset):
    val = [(key >> i*32) & 0xFFFFFFFF for i in range(8)]
    for w in range(len(val)):
        cmd_file.write("set keymem[{}][{}][{}] 0x{}\n".format(ktype, slot, offset+w, format(val[w], '08X')))

def get_key(kmem_array, ktype, slot, offset) -> int:
    val = 0
    for i in range(8):
        w = kmem_array[ktype][slot][offset+i]
        val += (int(w) << (i*32))
    return val

def break_on(cmd_file, bp):
    cmd_file.write(f"break {bp}\n")

def write_int32(cmd_file, x: int, addr):
    cmd_file.write("set mem[0x{}] 0x{}\n".format(format(addr, '04X'), format(x, '08X')))

def write_int256(cmd_file, x: int, addr):
    val = [(x >> i*32) & 0xFFFFFFFF for i in range(8)]
    for w in range(len(val)):
        write_int32(cmd_file, val[w], addr+(w*4))

def dump_gpr_on(cmd_file, bp, gpr: list) -> str:
    cmd_file.write(f"break {bp}\n")
    s = ""
    for r in gpr:
        s += f"get R{r}\n"
    s += "run\n"
    return s

def write_string(cmd_file, s: str, addr):
    val = str2int32(s)
    for w in range(len(val)):
        write_int32(cmd_file, val[w], addr+(w*4))

def write_bytes(cmd_file, b: bytes, addr):
    write_string(cmd_file, b.hex(), addr)

def set_rng(test_dir: str, rng: list):
    with open(f"{test_dir}/rng.hex", mode='w') as rng_hex:
        for r in rng:
            for i in range(8):
                rng_hex.write(format((r >> i*32) & 0xffffffff, '08X') + "\n")

def read_output(test_dir: str, run_name: str, addr: int, count: int, string=False):
    mem = addr & 0xF000
    if mem == 0x1000:
        output_file = f"{test_dir}/{run_name}_out.hex"
    elif mem == 0x5000:
        output_file = f"{test_dir}/{run_name}_emem_out.hex"
    else:
        raise Exception(f"Address {hex(addr)} is invalid output address!")

    if not string:
        with open(output_file, mode='r') as out:
            data = out.read().split('\n')
            idx = (addr - mem) // 4
            val = 0
            for i in range(count):
                val += int.from_bytes(binascii.unhexlify(data[idx+i].split(' ')[1]), 'big') << i*32
            return val
    else:
        with open(output_file, mode='r') as out:
            data = out.read().split('\n')
            idx = (addr - mem) // 4
            val = b''
            for i in range(count):
                val += int.from_bytes(binascii.unhexlify(data[idx+i].split(' ')[1]), 'little').to_bytes(4, 'big')
            return val
    
def run_op(
            cmd_file,           op_name,
            insrc,              outsrc,         data_in_size,
            ops_cfg,            test_dir,       run_name=None,
            main=None,          isa=2,          tag="Application",
            old_context=None,   keymem=None,    break_s=None
        ):

    op = find_in_list(op_name, ops_cfg)
    cfg_word = op["id"] + (outsrc << 8) + (insrc << 12) + (data_in_size << 16)
    set_cfg_word(cmd_file, cfg_word)
    run(cmd_file)
    if break_s:
        cmd_file.write(break_s)
    exit(cmd_file)
    cmd_file.close()

    iss = "spect_iss"
    if not run_name:
        run_name = op_name
    new_context = run_name+".ctx"
    run_log = run_name+"_iss.log"

    hexfile = "build/main.hex"
    constfile = "data/constants.hex"


    if "TS_SPECT_FW_TEST_RELEASE" in os.environ.keys():
        if tag == "Boot1":
            hexfile = "release_boot/mpw1/spect_boot_mpw1.hex"
            constdir = "release_boot/mpw1/constants.hex"
        elif tag == "Boot2":
            hexfile = "release_boot/mpw2/spect_boot_mpw2.hex"
            constdir = "release_boot/mpw2/constants.hex"
        elif tag == "Debug":
            hexfile = "release/spect_debug.hex"
            constdir = "release/constants.hex"
        else: # tag == "Application"
            hexfile = "release/spect_app.hex"
            constdir = "release/constants.hex"

    cmd = iss
    
    if ("TS_SPECT_FW_TEST_RELEASE" not in os.environ.keys()) and (break_s or main):
        if not main:
            main = "src/main.s"
        cmd += f" --program={TS_REPO_ROOT}/{main}"
        print(f"Source: {main}")
    else:
        cmd += f" --instruction-mem={TS_REPO_ROOT}/{hexfile}"
        cmd += f" --parity={fw_parity}"
        print(f"Source: {hexfile}")
    cmd += f" --isa-version={isa}"
    cmd += f" --first-address=0x8000"
    cmd += f" --const-rom={TS_REPO_ROOT}/{constfile}"
    cmd += f" --grv-hex={test_dir}/rng.hex"
    cmd += f" --data-ram-out={test_dir}/{run_name}_out.hex"
    cmd += f" --emem-out={test_dir}/{run_name}_emem_out.hex"
    cmd += f" --dump-keymem={test_dir}/{run_name}_keymem.hex"
    cmd += f" --dump-context={test_dir}/{new_context}"
    if keymem:
        cmd += f" --load-keymem={keymem}"
    if old_context:
        cmd += f" --load-context={test_dir}/{old_context}"
    cmd += f" --shell --cmd-file={test_dir}/iss_cmd"
    cmd += f" > {test_dir}/{run_log}"

    if os.system(cmd):
        print("ISS FAILED")
        sys.exit(2)

    return new_context
