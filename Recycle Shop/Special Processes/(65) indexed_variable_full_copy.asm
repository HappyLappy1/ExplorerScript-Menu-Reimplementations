; ------------------------------------------------------------------------------
; Indexed Variable Full Copy
; Copies all the indices of one script variable to the other!
; By Adex
; Param 1: game_var_id_to_overwrite
; Param 2: game_var_id_to_copy
; Returns: 0 if the variable's contents could not be copied due to a user error (attempting to use a non-indexed variable), 1 if successful!
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x810

; Uncomment/comment the following labels depending on your version.

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel LoadScriptVariableRaw, 0x204B49C
.definelabel LoadScriptVariableValueAtIndex, 0x204B678
.definelabel SaveScriptVariableValueAtIndex, 0x204B988

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel LoadScriptVariableRaw, 0x204B7D4
;.definelabel LoadScriptVariableValueAtIndex, 0x204B9B0
;.definelabel SaveScriptVariableValueAtIndex, 0x204BCC0


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		
		push r4,r5,r8
		sub r13,r13,#0x10
		mov r8,#0x0
		mov r0,r13
		mov r1,#0x0
		mov r2,r7
		bl LoadScriptVariableRaw
		add r0,r13,#0x8
		mov r1,#0x0
		mov r2,r6
		bl LoadScriptVariableRaw
		ldr r0,[r13,#0x0]
		ldrsh r4,[r0,#0x8]
		ldr r0,[r13,#0x8]
		ldrsh r1,[r0,#0x8]
		cmp r1,#0x1
		cmpgt r4,#0x1
		ble @@ret
		mov r5,#0x0
		b @@loop_check
@@loop:
		mov r0,#0x0
		mov r1,r6
		mov r2,r5
		bl LoadScriptVariableValueAtIndex
		mov r3,r0
		mov r2,r5
		mov r1,r7
		mov r0,#0x0
		bl SaveScriptVariableValueAtIndex
		add r5,r5,#0x1
@@loop_check:
		cmp r5,r4
		blt @@loop
		mov r8,#0x1
@@ret:
		mov r0,r8
		add r13,r13,#0x10
		pop r4,r5,r8
		b ProcJumpAddress
		.pool
	.endarea
.close
