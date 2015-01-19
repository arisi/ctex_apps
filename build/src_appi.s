	.syntax unified
	.cpu cortex-m3
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 1
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.thumb
	.file	"appi.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.section	buut,"ax",%progbits
	.align	2
	.global	appi
	.thumb
	.thumb_func
	.type	appi, %function
appi:
.LFB0:
	.file 1 "src/appi.c"
	.loc 1 39 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
.LVL0:
	push	{r3, r4, r5, lr}
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.cfi_offset 4, -12
	.cfi_offset 5, -8
	.cfi_offset 14, -4
.LVL1:
	.loc 1 43 0
	mov	r4, r0
	cbnz	r0, .L2
.LVL2:
	.loc 1 45 0
	ldr	r3, .L5
	mov	r0, r3
.LVL3:
	ldr	r1, .L5+4
	ldr	r2, .L5+8
	subs	r2, r2, r3
.LVL4:
	bl	memcpy
.LVL5:
	.loc 1 46 0
	movs	r2, #0
	ldr	r3, .L5+12
	str	r2, [r3]
	b	.L3
.LVL6:
.L2:
	.loc 1 48 0
	ldr	r2, .L5+12
	ldr	r3, [r2]
	adds	r3, r3, #1
	str	r3, [r2]
.LVL7:
.L3:
	.loc 1 49 0
	ldr	r5, .L5+12
	ldr	r0, [r5]
	bl	testeri
.LVL8:
	.loc 1 50 0
	ldr	r2, [r5]
	movs	r0, #2
	ldr	r1, .L5+16
	lsls	r2, r2, #1
	bl	my_fprintf
.LVL9:
	.loc 1 51 0
	add	r0, r4, r4, lsl #2
	.loc 1 52 0
	lsls	r0, r0, #1
	pop	{r3, r4, r5, pc}
.LVL10:
.L6:
	.align	2
.L5:
	.word	_sdata
	.word	_sidata
	.word	_edata
	.word	countti
	.word	.LC0
	.cfi_endproc
.LFE0:
	.size	appi, .-appi
	.global	dummy
	.global	jesutas
	.comm	countti,4,4
	.section	.rodata
	.align	2
	.type	dummy, %object
	.size	dummy, 17
dummy:
	.ascii	"123456789ABCXXXX\000"
	.data
	.align	2
	.type	jesutas, %object
	.size	jesutas, 18
jesutas:
	.ascii	"OUJEE TAMAONOIKEA\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"woi perseensuti! %d\012\000"
	.text
.Letext0:
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x1e0
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF22
	.byte	0x1
	.4byte	.LASF23
	.4byte	.LASF24
	.4byte	.Ldebug_ranges0+0
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x1
	.byte	0x6
	.4byte	0x70
	.uleb128 0x3
	.4byte	.LASF0
	.sleb128 0
	.uleb128 0x3
	.4byte	.LASF1
	.sleb128 1
	.uleb128 0x3
	.4byte	.LASF2
	.sleb128 2
	.uleb128 0x3
	.4byte	.LASF3
	.sleb128 3
	.uleb128 0x3
	.4byte	.LASF4
	.sleb128 4
	.uleb128 0x3
	.4byte	.LASF5
	.sleb128 5
	.uleb128 0x3
	.4byte	.LASF6
	.sleb128 6
	.uleb128 0x3
	.4byte	.LASF7
	.sleb128 7
	.uleb128 0x3
	.4byte	.LASF8
	.sleb128 8
	.uleb128 0x3
	.4byte	.LASF9
	.sleb128 9
	.uleb128 0x3
	.4byte	.LASF10
	.sleb128 10
	.byte	0
	.uleb128 0x4
	.4byte	.LASF25
	.byte	0x1
	.byte	0x1d
	.4byte	0x25
	.uleb128 0x5
	.4byte	.LASF26
	.byte	0x1
	.byte	0x27
	.4byte	0xed
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xed
	.uleb128 0x6
	.ascii	"z\000"
	.byte	0x1
	.byte	0x27
	.4byte	0xed
	.4byte	.LLST0
	.uleb128 0x7
	.ascii	"e\000"
	.byte	0x1
	.byte	0x28
	.4byte	0xed
	.uleb128 0x7
	.ascii	"s\000"
	.byte	0x1
	.byte	0x29
	.4byte	0xed
	.uleb128 0x8
	.ascii	"len\000"
	.byte	0x1
	.byte	0x2a
	.4byte	0xed
	.4byte	.LLST1
	.uleb128 0x9
	.4byte	.LVL5
	.4byte	0x182
	.uleb128 0x9
	.4byte	.LVL8
	.4byte	0x1a8
	.uleb128 0xa
	.4byte	.LVL9
	.4byte	0x1bd
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x1
	.byte	0x32
	.byte	0
	.byte	0
	.uleb128 0xc
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0xd
	.4byte	.LASF11
	.byte	0x1
	.byte	0x23
	.4byte	0xed
	.uleb128 0x5
	.byte	0x3
	.4byte	countti
	.uleb128 0xe
	.4byte	.LASF12
	.byte	0x1
	.byte	0x24
	.4byte	0x110
	.uleb128 0xf
	.byte	0x4
	.byte	0x7
	.4byte	.LASF13
	.uleb128 0xe
	.4byte	.LASF14
	.byte	0x1
	.byte	0x24
	.4byte	0x110
	.uleb128 0xe
	.4byte	.LASF15
	.byte	0x1
	.byte	0x24
	.4byte	0x110
	.uleb128 0x10
	.4byte	0x144
	.4byte	0x13d
	.uleb128 0x11
	.4byte	0x13d
	.byte	0x10
	.byte	0
	.uleb128 0xf
	.byte	0x4
	.byte	0x7
	.4byte	.LASF16
	.uleb128 0xf
	.byte	0x1
	.byte	0x8
	.4byte	.LASF17
	.uleb128 0xd
	.4byte	.LASF18
	.byte	0x1
	.byte	0x39
	.4byte	0x15c
	.uleb128 0x5
	.byte	0x3
	.4byte	dummy
	.uleb128 0x12
	.4byte	0x12d
	.uleb128 0x10
	.4byte	0x144
	.4byte	0x171
	.uleb128 0x11
	.4byte	0x13d
	.byte	0x11
	.byte	0
	.uleb128 0xd
	.4byte	.LASF19
	.byte	0x1
	.byte	0x37
	.4byte	0x161
	.uleb128 0x5
	.byte	0x3
	.4byte	jesutas
	.uleb128 0x13
	.4byte	.LASF27
	.4byte	0x19f
	.4byte	0x19f
	.uleb128 0x14
	.4byte	0x19f
	.uleb128 0x14
	.4byte	0x1a1
	.uleb128 0x14
	.4byte	0x13d
	.byte	0
	.uleb128 0x15
	.byte	0x4
	.uleb128 0x16
	.byte	0x4
	.4byte	0x1a7
	.uleb128 0x17
	.uleb128 0x18
	.4byte	.LASF20
	.byte	0x1
	.byte	0x26
	.4byte	0xed
	.4byte	0x1bd
	.uleb128 0x14
	.4byte	0xed
	.byte	0
	.uleb128 0x18
	.4byte	.LASF21
	.byte	0x1
	.byte	0x20
	.4byte	0xed
	.4byte	0x1d8
	.uleb128 0x14
	.4byte	0x70
	.uleb128 0x14
	.4byte	0x1d8
	.uleb128 0x19
	.byte	0
	.uleb128 0x16
	.byte	0x4
	.4byte	0x1de
	.uleb128 0x12
	.4byte	0x144
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x4
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",%progbits
.Ldebug_loc0:
.LLST0:
	.4byte	.LVL0
	.4byte	.LVL3
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL3
	.4byte	.LVL6
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL6
	.4byte	.LVL7
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL7
	.4byte	.LVL10
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL10
	.4byte	.LFE0
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL1
	.4byte	.LVL2
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL4
	.4byte	.LVL5-1
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL6
	.4byte	.LVL7
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LFB0
	.4byte	.LFE0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF11:
	.ascii	"countti\000"
.LASF13:
	.ascii	"unsigned int\000"
.LASF12:
	.ascii	"_sdata\000"
.LASF8:
	.ascii	"port_tft\000"
.LASF10:
	.ascii	"port_END\000"
.LASF19:
	.ascii	"jesutas\000"
.LASF18:
	.ascii	"dummy\000"
.LASF14:
	.ascii	"_sidata\000"
.LASF7:
	.ascii	"port_udp\000"
.LASF26:
	.ascii	"appi\000"
.LASF17:
	.ascii	"char\000"
.LASF9:
	.ascii	"port_video\000"
.LASF25:
	.ascii	"ports\000"
.LASF27:
	.ascii	"memcpy\000"
.LASF1:
	.ascii	"port_uart1\000"
.LASF2:
	.ascii	"port_uart2\000"
.LASF3:
	.ascii	"port_uart3\000"
.LASF24:
	.ascii	"/home/arisi/projects/ctex_app\000"
.LASF5:
	.ascii	"port_uart5\000"
.LASF6:
	.ascii	"port_uart6\000"
.LASF0:
	.ascii	"port_null\000"
.LASF15:
	.ascii	"_edata\000"
.LASF20:
	.ascii	"testeri\000"
.LASF4:
	.ascii	"port_uart4\000"
.LASF21:
	.ascii	"my_fprintf\000"
.LASF23:
	.ascii	"src/appi.c\000"
.LASF16:
	.ascii	"sizetype\000"
.LASF22:
	.ascii	"GNU C 4.9.2 -mcpu=cortex-m3 -mthumb -mfloat-abi=sof"
	.ascii	"t -g -O1 -std=gnu99\000"
	.ident	"GCC: (GNU) 4.9.2"
