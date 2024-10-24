; ------------------------------------------------------------------------------
; Equalize Indexed Variables
; By Adex
; Param 1: indexed_value_0
; Param 2: indexed_value_1
; Performs var[indexed_value_0] = var[indexed_value_1].
;
; NOTE: This process MUST be used immediately after "select_id", with its first parameter being the global variable you'd like!
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

; Uncomment/comment the following labels depending on your version.

.definelabel MaxSize, 0x810

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel GetGameVar, 0x0204B4EC
.definelabel GetGameVarIndexed, 0x0204B678
.definelabel SetGameVar, 0x0204B820
.definelabel SetGameVarIndexed, 0x0204B988

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel GetGameVar, 0x0204B824
;.definelabel GetGameVarIndexed, 0x0204B9B0
;.definelabel SetGameVar, 0x0204BB58
;.definelabel SetGameVarIndexed, 0x0204BCC0


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize

		push r4
		ldr r4,=ProcStartAddress+MaxSize-4
		ldr r4,[r4]
		mov r0,#0
		mov r1,r4
		mov r2,r6
		bl GetGameVarIndexed
		mov r3,r0
		mov r0,#0
		mov r1,r4
		mov r2,r7
		bl SetGameVarIndexed
		mov r0,#1
		pop r4
		b ProcJumpAddress
		.pool
	.endarea
.close