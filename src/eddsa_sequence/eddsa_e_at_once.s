op_eddsa_e_at_once:
    ; Load all data
    CALL        get_data_in_size
    MOV         r11, r0             ; number of bytes in message

    CALL        get_input_base
    ADDI        r30, r0,  eddsa_input_message
    LDR         r19, r30
    ADDI        r30, r30, 32
    LDR         r18, r30

    SWE         r19, r19
    SWE         r18, r18

    LD          r20, ca_eddsa_sign_internal_A
    LD          r21, ca_eddsa_sign_internal_R

    ; get size of message in bits
    ADDI        r29, r11, 64
    LSL         r29, r29
    LSL         r29, r29
    LSL         r29, r29            ; bitsize of message

    ; init hash unit
    HASH_IT

    CALL        eddsa_e_pad_mask

    CMPI        r9, 32
    BRZ         eddsa_e_finish_pad_in_r18   ; Use the code from e_finish
    MOV         r18, r29
    JMP         eddsa_e_finish_pad_in_r19 
