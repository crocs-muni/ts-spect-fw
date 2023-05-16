.include data/const_rom_leyout.s
;.include data/data_ram_in_leyout.s
.include src/mem_leyouts/eddsa_verify_mem_leyout.s

ca_command .eq 0x0000

_start:
    LD r0, ca_command

    CMPI r0, 0
    BRNZ next_cmd_1
    ;CALL ecdsa_key_setup
    END
next_cmd_1:
    CMPI r0, 1
    BRNZ next_cmd_2
    ;CALL ecdsa_sign
    END
next_cmd_2:
    CMPI r0, 2
    BRNZ next_cmd_3
    ;CALL x25519
    END

next_cmd_3:
    CMPI r0, 0x4A
    BRNZ next_cmd_4
    CALL eddsa_verify
    END

next_cmd_4:
    END

;.include    src/field_math/inv_q256.s
;.include    src/field_math/inv_p256.s
.include    src/field_math/inv_p25519.s

.include    src/ecc_math/point_compress_ed25519.s
.include    src/ecc_math/point_decompress_ed25519.s
;.include    src/ecc_math/point_add_p256.s
;.include    src/ecc_math/point_dub_p256.s
.include    src/ecc_math/point_add_ed25519.s
.include    src/ecc_math/point_dub_ed25519.s
;.include    src/ecc_math/spm_p256.s
.include    src/ecc_math/spm_ed25519_short.s

;.include    src/ecc_crypto/ecdsa_key_setup.s
;.include    src/ecc_crypto/ecdsa_sign.s
;.include    src/ecc_crypto/x25519.s
.include    src/ecc_crypto/eddsa_verify.s

