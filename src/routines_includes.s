; ====================================================
; Field Math
; ====================================================
;.include    field_math/inv_q256.s
.include    field_math/256/inv_p256.s
.include    field_math/25519/inv_p25519.s
.include    field_math/25519/sqrt_p25519.s

; ====================================================
; ECC Math
; ====================================================

; .......... Ed25519 ..........

.include   ecc_math/ed25519/point_compress_ed25519.s
.include   ecc_math/ed25519/point_decompress_ed25519.s
.include   ecc_math/ed25519/point_add_ed25519.s
.include   ecc_math/ed25519/point_dbl_ed25519.s
.include   ecc_math/ed25519/spm_ed25519_short.s
;.include   ecc_math/ed25519/spm_ed25519_long.s
.include    ecc_math/ed25519/point_check_ed25519.s

; .......... P256 ..........

.include   ecc_math/p256/point_add_p256.s
.include   ecc_math/p256/point_dbl_p256.s
.include   ecc_math/p256/spm_p256_short.s
;.include   ecc_math/p256/spm_p256_long.s
.include   ecc_math/p256/point_check_p256.s

; .......... Curve25519 ..........

.include    ecc_math/curve25519/get_y_curve25519.s
.include    ecc_math/curve25519/point_add_curve25519.s
.include    ecc_math/curve25519/point_check_curve25519.s
.include    ecc_math/curve25519/point_xadd_curve25519.s
.include    ecc_math/curve25519/point_xdbl_curve25519.s
.include    ecc_math/curve25519/spm_curve25519.s
.include    ecc_math/curve25519/y_recovery_curve25519.s

; ====================================================
; ECC Point Generation
; ====================================================

.include    ecc_point_generation/compose_exp_tag.s
.include    ecc_point_generation/hash_to_field_p25519.s
.include    ecc_point_generation/map_to_curve_elligator2_curve25519.s
.include    ecc_point_generation/point_generate_curve25519.s
;.include    ecc_point_generation/point_generate_ed25519.s

; ====================================================
; ECC Crypto
; ====================================================

.include   ecc_crypto/p256_key_setup.s
.include    ecc_crypto/ed25519_key_setup.s
;.include   ecc_crypto/ecdsa_sign.s
.include   ecc_crypto/eddsa_verify.s
.include    ecc_crypto/x25519_full_masked.s
;.include   ecc_crypto/x25519.s

; ====================================================
; SPECT Ops
; ====================================================

.include    ops/ecc_key_ops.s
.include    ops/ecdsa_ops.s
.include    ops/eddsa_ops.s
.include    ops/sha512_ops.s
.include    ops/x25519_ops.s
