; 
; ------------------------------------------------------------------------------
; Remove Bag
; By Irdkwia (Unable to find link, sorry)
; Remove current bag items
; Returns: nothing
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x810

; For US
;.include "lib/stdlib_us.asm"
;.definelabel ProcStartAddress, 0x022E7248
;.definelabel ProcJumpAddress, 0x022E7AC0
;.definelabel RemoveAllItemsStartingAt, 0x0200F7DC

; For EU
.include "lib/stdlib_eu.asm"
.definelabel ProcStartAddress, 0x022E7B88
.definelabel ProcJumpAddress, 0x022E8400
.definelabel RemoveAllItemsStartingAt, 0x0200F884


; File creation
.create "./code_out.bin", 0x022E7A80 ; Change to the actual offset as this directive doesn't accept labels
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		mov r0,#0
		bl RemoveAllItemsStartingAt
		b ProcJumpAddress
		.pool
	.endarea
.close
