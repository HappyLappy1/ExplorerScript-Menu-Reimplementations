; 
; ------------------------------------------------------------------------------
; Counts the amount of an item in the bag, based on item IDs from "item_Set"

; param 0: $VAR
; param 1: item_Set slot
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x810

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel GetGameVar, 0x0204B4EC
.definelabel SetGameVar, 0x0204B820
.definelabel CountNbItemsOfTypeInStorage, 0x200FEA8
.definelabel CountItemTypeInBag, 0x200EE88
.definelabel ItemAtTableIdx, 0x2065CF8

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel GetGameVar, 0x0204B824
;.definelabel SetGameVar, 0x0204BB58
;.definelabel CountNbItemsOfTypeInStorage, 0x200FF50
;.definelabel CountItemTypeInBag, 0x200EF30
;.definelabel ItemAtTableIdx, 0x2066074

; File creation
.create "./code_out.bin", 0x022E7248 ; Change to the actual offset as this directive doesn't accept labels
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		; Usable Variables: 
		; r7 = First Argument
		; r6 = Second Argument
		; Returns: 
		; r0 = User Defined Value
		; Registers r4 to r11 and r13 must remain unchanged after the execution of that code
        sub sp, sp, 0x8;
        push r10
        push r9
        mov r0,#0
        mov r1,r7
        bl GetGameVar
        mov r10,r0
        mov r0, r6 ; Has the slot number in it
        mov r1, sp ; ???
        bl ItemAtTableIdx;
        ldrh r0,[sp,#0x0]
        bl CountNbItemsOfTypeInStorage
        add r2,r0,r10
        mov r9, r2
        ldrh r0,[sp,#0x0]
        bl CountItemTypeInBag
        mov r2,r9
        add r2,r0,r2
        mov r0,#0
        mov r1,r7
        bl SetGameVar
        pop r9
        pop r10
        mov r0,#0
        add sp, sp, 0x8;
        b ProcJumpAddress
		.pool
	.endarea
.close                                                                                                      