#! /bin/bash

echo "*************************************************" 
echo "*  Compile Firmware"
echo "*************************************************" 

make -C .. compile

tests=("sha512" "x25519_full_sc" "ecc_key_gen" "ecc_key_read" "ecc_key_erase" "ecdsa_sign" "boot_sequence")

declare -i ret_val=0

echo ${1}

export TS_SPECT_FW_TEST_DONT_DUMP=""

for test in ${tests[@]}; do
    for VAR in {1..${1}}; do
        echo "*************************************************" 
        echo "*  Running test $test"
        echo "*************************************************" 
        ./test_$test.py
        if [ $? -ne 0 ]; then
            ret_val=$((ret_val + 1))
        fi
    done
done

echo "Failed $ret_val"

unset -f TS_SPECT_FW_TEST_DONT_DUMP

exit $ret_val