.include mem_leyouts/mem_leyouts_includes.s
.include spect_ops_constants.s
.include spect_descriptors_constants.s
.include spect_ops_status.s
_start:
    LD      r0, ca_spect_cfg_word

    ADDI    r0, r0, 0               ; force bits [255:32] to 0
    MOVI    r4, 0xFF

    AND     r1, r0, r4              ; mask SPECT_OP_ID to r1[7:0]
    MOVI    r4, 0xF0
    ROL8    r4, r4
    AND     r2, r0, r4              ; mask r0 so r2 = IN_SRC||000
    LSL     r3, r0
    LSL     r3, r3
    LSL     r3, r3
    LSL     r3, r3
    AND     r3, r3, r4              ; mask OUT_SRC

    ROR8    r0, r0
    ROR8    r0, r0
    MOVI    r4, 0xFF
    ROL8    r4, r4
    ORI     r4, r4, 0xFF
    AND     r0, r0, r4              ; r0 = SPECT_OP_DATA_IN_SIZE

op_id_check_clear:
    CMPI r1, clear_id
    BRZ  op_clear

op_id_check_sha512:
    CMPI r1, sha512_id
    BRZ  op_sha512

op_id_check_ecc_key:
    CMPI r1, ecc_key_id
    BRZ  op_ecc_key

op_id_check_x25519:
    CMPI r1, x25519_id
    BRZ  op_x25519

op_id_check_eddsa:
    CMPI r1, eddsa_id
    BRZ  op_eddsa

op_id_check_ecdsa:
    CMPI r1, ecdsa_id
    BRZ  op_ecdsa

; ============================================================
op_id_debug:
    MOVI    r30, 0
    ST      r30, ca_spect_res_word
    END

; ============================================================
op_clear:
    MOVI    r30, ret_op_success
    ST      r30, ca_spect_res_word
    MOVI    r30, clear_id
    JMP     __end__
; ============================================================
op_sha512:
    CMPI    r3, sha512_init_id
    BRZ     op_sha512_init

    CMPI    r3, sha512_update
    BRZ     op_sha512_update

    CMPI    r3, sha512_final
    BRZ     op_sha512_update
; ============================================================
op_ecc_key:
    CMPI    r3, ecc_key_gen_id
    BRZ     op_ecc_key_gen

    CMPI    r3, ecc_key_store_id
    BRZ     op_ecc_key_store

    CMPI    r3, ecc_key_read_id
    BRZ     op_ecc_key_read

    CMPI    r3, ecc_key_erase_id
    BRZ     op_ecc_key_erase

    JMP     invalid_op_id

; ============================================================
op_x25519:
; ============================================================
op_eddsa:
; ============================================================
op_ecdsa:
; ============================================================


; ============================================================
; Curve25519 Random Point Generation
;next_cmd_4:
;    CMPI r0, curve25519_rpg_id
;    BRNZ next_cmd_5
;    LD      r1, ca_dst_template
;    LD      r2, 0x0020              ; DST ID
;    OR      r1, r1, r2
;    ROL8    r1, r1
;    CALL    curve25519_point_generate
;    ST      r10, 0x1000 
;    ST      r11, 0x1020
;    ST      r12, 0x1040
;    END 
; ============================================================
; ============================================================
; Ed25519 Random Point Generation
;next_cmd_5:
;    CMPI r0, ed25519_rpg_id
;    BRNZ next_cmd_end
;    LD      r1, ca_dst_template
;    LD      r2, 0x0020              ; DST ID
;    OR      r1, r1, r2
;    ROL8    r1, r1
;    CALL    ed25519_point_generate
;    ST      r10, 0x1000 
;    ST      r11, 0x1020
;    ST      r12, 0x1040
;    END 
; ============================================================

invalid_op_id:
    MOVI    r30, ret_op_id_err
    ST      r30, ca_op_status
__end__:
    ST      r30, 0x1000
    ROL8    r0, r0
    ROL8    r0, r0
    ST      r0, ca_spect_res_word
    END

;.include    field_math/inv_q256.s
;.include    field_math/inv_p256.s
;.include    field_math/inv_p25519.s

;.include    ecc_math/point_compress_ed25519.s
;.include    ecc_math/point_decompress_ed25519.s
;.include    ecc_math/point_add_p256.s
;.include    ecc_math/point_dub_p256.s
;.include    ecc_math/point_add_ed25519.s
;.include    ecc_math/point_dub_ed25519.s
;.include    ecc_math/spm_p256.s
;.include    ecc_math/spm_ed25519_short.s

;.include    ecc_point_generation/hash_to_field_p25519.s
;.include    ecc_point_generation/map_to_curve_elligator2_curve25519.s
;.include    ecc_point_generation/point_generate_curve25519.s
;.include    ecc_point_generation/point_generate_ed25519.s
;.include    ecc_point_generation/compose_exp_tag.s

;.include    ecc_crypto/ecdsa_key_setup.s
;.include    ecc_crypto/ecdsa_sign.s
;.include    ecc_crypto/x25519.s
;.include    ecc_crypto/eddsa_verify.s

;.include    ops/sha512_routines.s
next_cmd_4:
    CMPI r0, curve25519_rpg_id
    BRNZ next_cmd_5
    LD      r1, ca_dst_template
    LD      r2, 0x0020              ; DST ID
    OR      r1, r1, r2
    ROL8    r1, r1
    CALL    curve25519_point_generate
    ST      r10, 0x1000 
    ST      r11, 0x1020
    ST      r12, 0x1040
    END 
; ============================================================
; ============================================================
; Ed25519 Random Point Generation
next_cmd_5:
    CMPI r0, ed25519_rpg_id
    BRNZ next_cmd_end
    LD      r1, ca_dst_template
    LD      r2, 0x0020              ; DST ID
    OR      r1, r1, r2
    ROL8    r1, r1
    CALL    ed25519_point_generate
    ST      r10, 0x1000 
    ST      r11, 0x1020
    ST      r12, 0x1040
    END 
; ============================================================

next_cmd_end:
    END

.include    field_math/inv_q256.s
;.include    field_math/inv_p256.s
.include    field_math/inv_p25519.s

