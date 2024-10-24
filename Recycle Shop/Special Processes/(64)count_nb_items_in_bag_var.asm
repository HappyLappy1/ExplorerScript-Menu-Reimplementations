; ------------------------------------------------------------------------------
; Count Nb Items In Bag Var
;
; Param 1: game_var_id
; Param 2: item_id
; Returns: Nothing, but the variable defined in Param 1 will increase by the number of specified items in the bag
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
.definelabel GetGameVar, 0x0204B4EC
.definelabel SetGameVar, 0x0204B820
.definelabel CountItemTypeInBag, 0x200EE88

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel GetGameVar, 0x0204B824
;.definelabel SetGameVar, 0x0204BB58
;.definelabel CountItemTypeInBag, 0x200EF30

; File creation
.create "./code_out.bin", 0x022E7248
	.org ProcStartAddress
	.area MaxSize
		push r10
		mov r0,#0
		mov r1,r7
		bl GetGameVar
		mov r10,r0
		mov r0,r6
		bl CountItemTypeInBag
		add r2,r0,r10
		mov r0,#0
		mov r1,r7
		bl SetGameVar
		pop r10
		mov r0,#0
		b ProcJumpAddress
		.pool
	.endarea
.close
