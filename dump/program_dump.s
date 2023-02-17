0x8000: _start:        LD        R0,0
0x8004:                CMPI      ,R0,0
0x8008:                BRNZ      8014
0x800c:                CALL      84d0
0x8010:                END       
0x8014: next_cmd_1:    CMPI      ,R0,1
0x8018:                BRNZ      8024
0x801c:                CALL      8518
0x8020:                END       
0x8024: next_cmd_2:    CMPI      ,R0,2
0x8028:                BRNZ      8034
0x802c:                CALL      863c
0x8030:                END       
0x8034: next_cmd_3:    END       
0x8038: inv_q256:      MULP      R2,R26,R26
0x803c:                MULP      R3,R2,R26
0x8040:                MULP      R4,R3,R3
0x8044:                MULP      R4,R4,R4
0x8048:                MULP      R5,R4,R3
0x804c:                MULP      R4,R5,R5
0x8050:                MULP      R4,R4,R4
0x8054:                MULP      R4,R4,R4
0x8058:                MULP      R4,R4,R4
0x805c:                MULP      R5,R4,R5
0x8060:                MULP      R4,R5,R5
0x8064:                MULP      R4,R4,R4
0x8068:                MOVI      R30,6
0x806c: inv_q256_loop_8:MULP      R4,R4,R4
0x8070:                MULP      R4,R4,R4
0x8074:                MULP      R4,R4,R4
0x8078:                SUBI      R30,R30,3
0x807c:                BRNZ      806c
0x8080:                MULP      R5,R4,R5
0x8084:                MULP      R4,R5,R5
0x8088:                MOVI      R30,15
0x808c: inv_q256_loop_16:MULP      R4,R4,R4
0x8090:                MULP      R4,R4,R4
0x8094:                MULP      R4,R4,R4
0x8098:                SUBI      R30,R30,3
0x809c:                BRNZ      808c
0x80a0:                MULP      R6,R4,R5
0x80a4:                MULP      R4,R6,R6
0x80a8:                MOVI      R30,63
0x80ac: inv_q256_loop_64:MULP      R4,R4,R4
0x80b0:                MULP      R4,R4,R4
0x80b4:                MULP      R4,R4,R4
0x80b8:                SUBI      R30,R30,3
0x80bc:                BRNZ      80ac
0x80c0:                MULP      R5,R4,R6
0x80c4:                MULP      R4,R5,R5
0x80c8:                MULP      R4,R4,R4
0x80cc:                MOVI      R30,30
0x80d0: inv_q256_loop_32:MULP      R4,R4,R4
0x80d4:                MULP      R4,R4,R4
0x80d8:                MULP      R4,R4,R4
0x80dc:                SUBI      R30,R30,3
0x80e0:                BRNZ      80d0
0x80e4:                MULP      R4,R4,R6
0x80e8:                LD        R5,12352
0x80ec:                MOVI      R30,128
0x80f0: inv_q256_loop_lowpart:MULP      R4,R4,R4
0x80f4:                MULP      R4,R4,R4
0x80f8:                LSL       R5,R5
0x80fc:                BRC       8110
0x8100: inv_q256_loop_x0:LSL       R5,R5
0x8104:                BRNC      8124
0x8108: inv_q256_loop_x01:MULP      R4,R4,R26
0x810c:                JMP       8124
0x8110: inv_q256_loop_x1:LSL       R5,R5
0x8114:                BRC       8120
0x8118: inv_q256_loop_x10:MULP      R4,R4,R2
0x811c:                JMP       8124
0x8120: inv_q256_loop_x11:MULP      R4,R4,R3
0x8124: inv_q256_loop_lowpart_back:SUBI      R30,R30,2
0x8128:                BRNZ      80f0
0x812c:                MOV       R26,R4
0x8130:                RET       
0x8134: inv_p256:      MUL256    R3,R1,R1
0x8138:                MUL256    R4,R3,R1
0x813c:                MUL256    R3,R4,R4
0x8140:                MUL256    R3,R3,R3
0x8144:                MUL256    R2,R3,R4
0x8148:                MUL256    R3,R2,R2
0x814c:                MUL256    R3,R3,R3
0x8150:                MUL256    R3,R3,R3
0x8154:                MUL256    R3,R3,R3
0x8158:                MUL256    R3,R3,R2
0x815c:                MUL256    R3,R3,R3
0x8160:                MUL256    R3,R3,R3
0x8164:                MUL256    R5,R3,R4
0x8168:                MUL256    R3,R5,R5
0x816c:                MOVI      R30,9
0x8170: inv_p256_loop_10_1:MUL256    R3,R3,R3
0x8174:                SUBI      R30,R30,1
0x8178:                BRNZ      8170
0x817c:                MUL256    R3,R3,R5
0x8180:                MOVI      R30,10
0x8184: inv_p256_loop_10_2:MUL256    R3,R3,R3
0x8188:                MUL256    R3,R3,R3
0x818c:                SUBI      R30,R30,2
0x8190:                BRNZ      8184
0x8194:                MUL256    R5,R3,R5
0x8198:                MUL256    R3,R5,R5
0x819c:                MUL256    R3,R3,R3
0x81a0:                MUL256    R2,R3,R4
0x81a4:                MUL256    R3,R2,R2
0x81a8:                MUL256    R3,R3,R3
0x81ac:                MOVI      R30,30
0x81b0: inv_p256_loop_30_1:MUL256    R3,R3,R3
0x81b4:                MUL256    R3,R3,R3
0x81b8:                MUL256    R3,R3,R3
0x81bc:                SUBI      R30,R30,3
0x81c0:                BRNZ      81b0
0x81c4:                MUL256    R3,R3,R1
0x81c8:                MOVI      R30,128
0x81cc: inv_p256_loop_128:MUL256    R3,R3,R3
0x81d0:                MUL256    R3,R3,R3
0x81d4:                MUL256    R3,R3,R3
0x81d8:                MUL256    R3,R3,R3
0x81dc:                SUBI      R30,R30,4
0x81e0:                BRNZ      81cc
0x81e4:                MUL256    R3,R3,R2
0x81e8:                MOVI      R30,32
0x81ec: inv_p256_loop_32:MUL256    R3,R3,R3
0x81f0:                MUL256    R3,R3,R3
0x81f4:                MUL256    R3,R3,R3
0x81f8:                MUL256    R3,R3,R3
0x81fc:                SUBI      R30,R30,4
0x8200:                BRNZ      81ec
0x8204:                MUL256    R3,R3,R2
0x8208:                MOVI      R30,30
0x820c: inv_p256_loop_30_2:MUL256    R3,R3,R3
0x8210:                MUL256    R3,R3,R3
0x8214:                MUL256    R3,R3,R3
0x8218:                SUBI      R30,R30,3
0x821c:                BRNZ      820c
0x8220:                MUL256    R3,R3,R5
0x8224:                MUL256    R3,R3,R3
0x8228:                MUL256    R3,R3,R3
0x822c:                MUL256    R1,R3,R1
0x8230:                RET       
0x8234: inv_p25519:    MUL25519  R2,R1,R1
0x8238:                MUL25519  R4,R2,R1
0x823c:                MUL25519  R3,R4,R4
0x8240:                MUL25519  R3,R3,R3
0x8244:                MUL25519  R2,R4,R3
0x8248:                MUL25519  R3,R2,R2
0x824c:                MUL25519  R3,R3,R3
0x8250:                MUL25519  R3,R3,R3
0x8254:                MUL25519  R3,R3,R3
0x8258:                MUL25519  R2,R2,R3
0x825c:                MUL25519  R3,R2,R2
0x8260:                MOVI      R30,7
0x8264: inv_p25519_loop_8:MUL25519  R3,R3,R3
0x8268:                SUBI      R30,R30,1
0x826c:                BRNZ      8264
0x8270:                MUL25519  R5,R2,R3
0x8274:                MUL25519  R3,R5,R5
0x8278:                MOVI      R30,15
0x827c: inv_p25519_loop_16_1:MUL25519  R3,R3,R3
0x8280:                SUBI      R30,R30,1
0x8284:                BRNZ      827c
0x8288:                MUL25519  R2,R5,R3
0x828c:                MUL25519  R3,R2,R2
0x8290:                MOVI      R30,15
0x8294: inv_p25519_loop_16_2:MUL25519  R3,R3,R3
0x8298:                SUBI      R30,R30,1
0x829c:                BRNZ      8294
0x82a0:                MUL25519  R2,R5,R3
0x82a4:                MUL25519  R2,R2,R2
0x82a8:                MUL25519  R2,R2,R2
0x82ac:                MUL25519  R5,R2,R4
0x82b0:                MUL25519  R3,R5,R5
0x82b4:                MOVI      R30,49
0x82b8: inv_p25519_loop_50_1:MUL25519  R3,R3,R3
0x82bc:                SUBI      R30,R30,1
0x82c0:                BRNZ      82b8
0x82c4:                MUL25519  R2,R5,R3
0x82c8:                MUL25519  R3,R2,R2
0x82cc:                MOVI      R30,99
0x82d0: inv_p25519_loop_100:MUL25519  R3,R3,R3
0x82d4:                SUBI      R30,R30,1
0x82d8:                BRNZ      82d0
0x82dc:                MUL25519  R2,R2,R3
0x82e0:                MUL25519  R3,R2,R2
0x82e4:                MOVI      R30,49
0x82e8: inv_p25519_loop_50_2:MUL25519  R3,R3,R3
0x82ec:                SUBI      R30,R30,1
0x82f0:                BRNZ      82e8
0x82f4:                MUL25519  R2,R3,R5
0x82f8:                MUL25519  R3,R2,R2
0x82fc:                MUL25519  R3,R3,R3
0x8300:                MUL25519  R3,R3,R1
0x8304:                MUL25519  R3,R3,R3
0x8308:                MUL25519  R3,R3,R3
0x830c:                MUL25519  R3,R3,R3
0x8310:                MUL25519  R1,R3,R4
0x8314:                RET       
0x8318: point_add_p256:MUL256    R0,R9,R12
0x831c:                MUL256    R1,R10,R13
0x8320:                MUL256    R2,R11,R14
0x8324:                ADDP      R3,R9,R10
0x8328:                ADDP      R4,R12,R13
0x832c:                MUL256    R3,R3,R4
0x8330:                ADDP      R4,R0,R1
0x8334:                SUBP      R3,R3,R4
0x8338:                ADDP      R4,R10,R11
0x833c:                ADDP      R5,R13,R14
0x8340:                MUL256    R4,R4,R5
0x8344:                ADDP      R5,R1,R2
0x8348:                SUBP      R4,R4,R5
0x834c:                ADDP      R5,R9,R11
0x8350:                ADDP      R6,R12,R14
0x8354:                MUL256    R5,R5,R6
0x8358:                ADDP      R6,R0,R2
0x835c:                SUBP      R6,R5,R6
0x8360:                MUL256    R7,R8,R2
0x8364:                SUBP      R5,R6,R7
0x8368:                ADDP      R7,R5,R5
0x836c:                ADDP      R5,R5,R7
0x8370:                SUBP      R7,R1,R5
0x8374:                ADDP      R5,R1,R5
0x8378:                MUL256    R6,R8,R6
0x837c:                ADDP      R1,R2,R2
0x8380:                ADDP      R2,R1,R2
0x8384:                SUBP      R6,R6,R2
0x8388:                SUBP      R6,R6,R0
0x838c:                ADDP      R1,R6,R6
0x8390:                ADDP      R6,R1,R6
0x8394:                ADDP      R1,R0,R0
0x8398:                ADDP      R0,R1,R0
0x839c:                SUBP      R0,R0,R2
0x83a0:                MUL256    R1,R4,R6
0x83a4:                MUL256    R2,R0,R6
0x83a8:                MUL256    R6,R5,R7
0x83ac:                ADDP      R13,R6,R2
0x83b0:                MUL256    R5,R3,R5
0x83b4:                SUBP      R12,R5,R1
0x83b8:                MUL256    R7,R4,R7
0x83bc:                MUL256    R1,R3,R0
0x83c0:                ADDP      R14,R7,R1
0x83c4:                RET       
0x83c8: point_dub_p256:MUL256    R0,R9,R9
0x83cc:                MUL256    R1,R10,R10
0x83d0:                MUL256    R2,R11,R11
0x83d4:                MUL256    R3,R9,R10
0x83d8:                ADDP      R3,R3,R3
0x83dc:                MUL256    R7,R9,R11
0x83e0:                ADDP      R7,R7,R7
0x83e4:                MUL256    R6,R8,R2
0x83e8:                SUBP      R6,R6,R7
0x83ec:                ADDP      R5,R6,R6
0x83f0:                ADDP      R6,R5,R6
0x83f4:                SUBP      R5,R1,R6
0x83f8:                ADDP      R6,R1,R6
0x83fc:                MUL256    R6,R5,R6
0x8400:                MUL256    R5,R5,R3
0x8404:                ADDP      R3,R2,R2
0x8408:                ADDP      R2,R2,R3
0x840c:                MUL256    R7,R8,R7
0x8410:                SUBP      R7,R7,R2
0x8414:                SUBP      R7,R7,R0
0x8418:                ADDP      R3,R7,R7
0x841c:                ADDP      R7,R7,R3
0x8420:                ADDP      R3,R0,R0
0x8424:                ADDP      R0,R3,R0
0x8428:                SUBP      R0,R0,R2
0x842c:                MUL256    R0,R0,R7
0x8430:                ADDP      R6,R6,R0
0x8434:                MUL256    R0,R10,R11
0x8438:                ADDP      R0,R0,R0
0x843c:                MUL256    R7,R0,R7
0x8440:                SUBP      R5,R5,R7
0x8444:                MUL256    R7,R0,R1
0x8448:                ADDP      R7,R7,R7
0x844c:                ADDP      R7,R7,R7
0x8450:                MOV       R9,R5
0x8454:                MOV       R10,R6
0x8458:                MOV       R11,R7
0x845c:                RET       
0x8460: spm_p256:      MOVI      R9,0
0x8464:                MOVI      R10,1
0x8468:                MOVI      R11,0
0x846c:                MOVI      R30,256
0x8470: spm_p256_loop_511_256:ROL       R29,R29
0x8474:                CSWAP     R9,R12
0x8478:                CSWAP     R10,R13
0x847c:                CSWAP     R11,R14
0x8480:                CALL      8318
0x8484:                CALL      83c8
0x8488:                CSWAP     R9,R12
0x848c:                CSWAP     R10,R13
0x8490:                CSWAP     R11,R14
0x8494:                SUBI      R30,R30,1
0x8498:                BRNZ      8470
0x849c:                MOVI      R30,256
0x84a0: spm_p256_loop_255_0:ROL       R28,R28
0x84a4:                CSWAP     R9,R12
0x84a8:                CSWAP     R10,R13
0x84ac:                CSWAP     R11,R14
0x84b0:                CALL      8318
0x84b4:                CALL      83c8
0x84b8:                CSWAP     R9,R12
0x84bc:                CSWAP     R10,R13
0x84c0:                CSWAP     R11,R14
0x84c4:                SUBI      R30,R30,1
0x84c8:                BRNZ      84a0
0x84cc:                RET       
0x84d0: ecdsa_key_setup:LD        R28,32
0x84d4:                ST        R28,4160
0x84d8:                LD        R31,12320
0x84dc:                GRV       R27
0x84e0:                SCB       R28,R28,R27
0x84e4:                LD        R31,12288
0x84e8:                LD        R8,12384
0x84ec:                LD        R12,12416
0x84f0:                LD        R13,12448
0x84f4:                MOVI      R14,1
0x84f8:                CALL      8460
0x84fc:                MOV       R1,R11
0x8500:                CALL      8134
0x8504:                MUL256    R9,R9,R1
0x8508:                MUL256    R10,R10,R1
0x850c:                ST        R9,4096
0x8510:                ST        R10,4128
0x8514:                RET       
0x8518: ecdsa_sign:    LD        R26,96
0x851c:                LD        R31,12320
0x8520:                GRV       R27
0x8524:                SCB       R28,R26,R27
0x8528:                CALL      8038
0x852c:                LD        R31,12288
0x8530:                LD        R8,12384
0x8534:                LD        R12,12416
0x8538:                LD        R13,12448
0x853c:                MOVI      R14,1
0x8540:                CALL      8460
0x8544:                MOV       R1,R11
0x8548:                CALL      8134
0x854c:                MUL256    R9,R9,R1
0x8550:                MOVI      R10,0
0x8554:                REDP      R9,R10,R9
0x8558:                CMPA      ,R9,0
0x855c:                BRZ       85b8
0x8560:                LD        R1,128
0x8564:                SUBP      R1,R1,R9
0x8568:                CMPA      ,R1,0
0x856c:                BRNZ      85c4
0x8570:                ST        R9,4096
0x8574:                LD        R31,12320
0x8578:                LD        R24,32
0x857c:                LD        R25,64
0x8580:                MULP      R0,R24,R9
0x8584:                ADDP      R0,R0,R25
0x8588:                MULP      R0,R0,R26
0x858c:                CMPA      ,R0,0
0x8590:                BRZ       85b8
0x8594:                LD        R31,12288
0x8598:                LD        R1,160
0x859c:                SUBP      R1,R1,R0
0x85a0:                CMPA      ,R1,0
0x85a4:                BRNZ      85d0
0x85a8:                ST        R0,4128
0x85ac:                MOVI      R0,1
0x85b0:                ST        R0,4160
0x85b4:                RET       
0x85b8: ecdsa_fail:    MOVI      R0,2
0x85bc:                ST        R0,4160
0x85c0:                RET       
0x85c4: ecdsa_fail_r:  MOVI      R0,3
0x85c8:                ST        R0,4160
0x85cc:                RET       
0x85d0: ecdsa_fail_s:  MOVI      R0,4
0x85d4:                ST        R0,4160
0x85d8:                RET       
0x85dc: x25519_calculation:CSWAP     R11,R13
0x85e0:                CSWAP     R12,R14
0x85e4:                ADDP      R1,R11,R12
0x85e8:                MUL25519  R2,R1,R1
0x85ec:                SUBP      R3,R11,R12
0x85f0:                MUL25519  R4,R3,R3
0x85f4:                SUBP      R5,R2,R4
0x85f8:                ADDP      R6,R13,R14
0x85fc:                SUBP      R7,R13,R14
0x8600:                MUL25519  R8,R7,R1
0x8604:                MUL25519  R9,R6,R3
0x8608:                ADDP      R13,R8,R9
0x860c:                MUL25519  R13,R13,R13
0x8610:                SUBP      R14,R8,R9
0x8614:                MUL25519  R14,R14,R14
0x8618:                MUL25519  R14,R10,R14
0x861c:                MUL25519  R11,R2,R4
0x8620:                LD        R1,12672
0x8624:                MUL25519  R12,R1,R5
0x8628:                ADDP      R12,R2,R12
0x862c:                MUL25519  R12,R5,R12
0x8630:                CSWAP     R11,R13
0x8634:                CSWAP     R12,R14
0x8638:                RET       
0x863c: x25519:        LD        R10,224
0x8640:                LD        R28,192
0x8644:                ANDI      R28,R28,3967
0x8648:                ORI       R28,R28,64
0x864c:                SWE       R28,R28
0x8650:                ANDI      R28,R28,4088
0x8654:                LD        R31,12544
0x8658:                GRV       R3
0x865c:                SCB       R28,R28,R3
0x8660:                SWE       R10,R10
0x8664:                MOVI      R11,1
0x8668:                MOVI      R12,0
0x866c:                MOV       R13,R10
0x8670:                MOVI      R14,1
0x8674:                LD        R31,12480
0x8678:                MOVI      R30,256
0x867c: x25519_loop_512_256:ROL       R29,R29
0x8680:                CALL      85dc
0x8684:                SUBI      R30,R30,1
0x8688:                BRNZ      867c
0x868c:                MOVI      R30,256
0x8690: x25519_loop_255_0:ROL       R28,R28
0x8694:                CALL      85dc
0x8698:                SUBI      R30,R30,1
0x869c:                BRNZ      8690
0x86a0:                MOV       R1,R12
0x86a4:                CALL      8234
0x86a8:                MUL25519  R10,R11,R1
0x86ac:                SWE       R10,R10
0x86b0:                ST        R10,4096
0x86b4:                RET       
