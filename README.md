# TS SPECT Firmware

This repository contains the Makefile and associated scripts necessary to build firmware for a specific project. The primary Makefile, named `Makefile`, orchestrates the build process and provides various targets for compiling, releasing, and managing the firmware.

## Licensing
---
Everything in this repository is licensed under the Apache License, Version 2.0, unless otherwise stated (for the complete wording, see [LICENSE file](LICENSE)).

## Documentation
---
Detailed documentation and resources can be found in the [`doc/`](doc/) folder
of this repository.

## Prerequisites
---
1. Cloning repository and setting the environment variable `TS_REPO_ROOT` to the repository root.

   ```bash
   # clone the spect firmware repository 
   git clone https://github.com/tropicsquare/ts-spect-fw.git --recurse-submodules

   # set env var TS_REPO_ROOT from root of repository
   cd ts-spect-fw
   export TS_REPO_ROOT=`pwd`
   ```

2. Ensure you have the `spect_compiler` and `spect_iss` binaries in the environment path. These are part
of the [`ts-spect-compiler`](https://github.com/tropicsquare/ts-spect-compiler)
repository.

   ```bash
   spect_compiler --help
   spect_iss --help
   ```

3. Ensure that Python and certain Python packages are installed on your system or python environment:
   ```bash
   pip install -r requirements.txt
   ```

## Build firmware
---
The primary [`makefile`](makefile) orchestrates the build process and provides
various targets for compiling, releasing and managing the firmware.


1. Run the desired build target using `make`. For example, to compile and
release firmware, use:

   ```bash
   make compile && make release_all
   ```

2. For a complete list of targets, consult the makefile or run:
   ```bash
   grep : makefile | awk -F: '/^[^.]/ {print $1;}'
   ```

3. The firmware build artifacts will be generated in the appropriate directories
, such as [`build/`](build/) and [`release/`](release/).

## Test/Simulate firmware
---
Python scrips for firmware testing and simulation are located in [`tests`](tests) directory. The scripts generates or read test vector, preload SPECTs input buffers and key slots, setup configuration files for `spect_iss` and run it.

Firmware must be compiled in [`build`](build) beforehand. Use:

   ```bash
   make compile
   ```

### Test Vectors

Tests are randomized by default. Test vectors are generated for each run using python models in [`models`](tests/models). 

Test vectors can be also specified using YAML file and `--testvec` option to define parameters of test (private, public key, z coordinate, randomization). 

See [`testvec`](tests/testvec) for test vector examples.

> **_NOTE:_** Only [`test_x25519_dbg.py`](tests/test_x25519_dbg.py) and [`test_ecdsa_dbg.py`](tests/test_ecdsa_dbg.py) currently supports custom test vectors.


   ```bash
   cd tests
   ```
   
   ```bash
   ./test_x25519_dbg.py --testvec testvec/x25519_dbg_testvec.yml
   ```

   ```bash
   ./test_x25519_dbg.py --testvec testvec/x25519_dbg_testvec.yml
   ```

   The test_*.py file controls test execution, output logs generate in tests/<test_name_directory> 
