; 
; ------------------------------------------------------------------------------
; Retrieve Today's Offer
; by happylappy
; param 0: value to write to the current offer
; param 1: nothing
; returns nothing, but the internal offer value will be set as you specify!
; Note: -1 means "No Offer"/"Offer Consumed"
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x810

; Uncomment the correct version

; For US
;.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel GAME_STATE_VALUES, 0x020AF6B8

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7A80
;.definelabel ProcJumpAddress, 0x022E7B88
;.definelabel GAME_STATE_VALUES, 0x020AFF70


; File creation
.create "./code_out.bin", 0x022E7248 ; Change to the actual offset as this directive doesn't accept labels
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
        ldr r0,=GAME_STATE_VALUES
        ldr r0, [r0, #0x0]
        add r0,r0,#0x1300
        strh r7,[r0,#0xb2]
		b ProcJumpAddress
		.pool
	.endarea
.close
