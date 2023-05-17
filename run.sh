#! /bin/bash

RUNDIR=$TS_REPO_ROOT/spect_fw
SPECT_APPS_PATH=$TS_REPO_ROOT/compiler/build/src/apps

cd $TS_REPO_ROOT/scripts
./gen_mem_files.py $RUNDIR/data/const_rom_config.yml
#./gen_mem_files.py $RUNDIR/data/data_ram_in_config.yml
./gen_mem_files.py $RUNDIR/data/eddsa_verify_data_in.yml
./gen_grv_hex.py $RUNDIR/data/random_data.yml

cd $SPECT_APPS_PATH

./spect_compiler --hex-format=1 --hex-file=$RUNDIR/main.hex \
--first-address=0x8000 \
--dump-program=$RUNDIR/dump/program_dump.s \
--dump-symbols=$RUNDIR/dump/symbols_dump \
$RUNDIR/main.s > $RUNDIR/log/compile.log

#echo $?
if [ ! $? -eq 0 ]
then
    echo "spect_compiler faild to compile the program."
    exit
fi

./spect_iss --instruction-mem=$RUNDIR/main.hex \
--const-rom=$RUNDIR/data/const_rom.hex \
--data-ram-in=$RUNDIR/data/data_ram_in.hex \
--data-ram-out=$RUNDIR/data/out.hex \
--grv-hex=$RUNDIR/data/grv.hex \
--shell --cmd-file=$RUNDIR/iss_cmd_file > $RUNDIR/log/iss.log
