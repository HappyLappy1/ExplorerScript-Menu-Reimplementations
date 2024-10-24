; 
; ---------------------------------------------------------------------------------------------------------
; Remove_Item_Set_From_Bag_Or_Storage by happylappy (with help from Adex & Hecka)
; Tries to remove one item from the bag if possible. If it fails, will try to remove one item from storage. 
; The removed item is will be taken from the specifie "item_Set" slot
; param 0: item_Set slot: 0, 1, 2, or 3 (4+ is corrupt) 
; param 1: Nothing
; returns 2 if taken from bag, 1 if taken from storage, and 0 if it failed both!
; ---------------------------------------------------------------------------------------------------------


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
.definelabel CountItemTypeInStorage, 0x200FEE4
.definelabel CountItemTypeInBag, 0x200EE88
.definelabel ItemAtTableIdx, 0x2065CF8
.definelabel RemoveBulkItemInStorage, 0x20101E4
.definelabel GetFirstUnequippedItemOfType, 0x200F26C
.definelabel GetItemAtIdx, 0x200F348
.definelabel ClearItemCheckTrue, 0x020582E0
.definelabel RemoveItemNoHole, 0x200F390

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel GetGameVar, 0x0204B824
;.definelabel SetGameVar, 0x0204BB58
;.definelabel CountItemTypeInStorage, 0x200FF8C
;.definelabel CountItemTypeInBag, 0x200EF30
;.definelabel ItemAtTableIdx, 0x2066074
;.definelabel RemoveBulkItemInStorage, 0x201028C
;.definelabel GetFirstUnequippedItemOfType, 0x200F314
;.definelabel GetItemAtIdx, 0x200F3F0
;.definelabel ClearItemCheckTrue, 0x0205865C
;.definelabel RemoveItemNoHole, 0x200F438

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
        sub sp, sp, 0x4;
        mov r0, r7 ; Has the slot number in it
        mov r1, sp ; Where to store it
        bl ItemAtTableIdx;
        ldrh r1,[sp,#0x0]
        remove_item_from_bag:
            ldrh r0, [sp,#0]; Put the item id into r0
            bl GetFirstUnequippedItemOfType
            mov r4, r0
            mvn r1, #0
            cmp r4, r1
            beq return_zero
            bl GetItemAtIdx
            ldrb r0, [r0, #1]
            cmp r0, #0
            beq not_held_by_anyone
            bl ClearItemCheckTrue ; [UNDOCUMENTED] NA: 0x020582E0, EU: 0x0205865C
        not_held_by_anyone:
            mov r0, r4
            bl RemoveItemNoHole
            mov r0, #2; idk, 2 for bag, 1 for storage, 0 for neither?
            b return;
        return_zero:
            mov r0, sp; It failed to take it out of the bag, so take it out of storage!
            bl RemoveBulkItemInStorage
            ; r0 is 1 if successful, 0 if failed
            b return
		return:
			add sp, sp, #0x4;
			b ProcJumpAddress
		.pool
	.endarea
.close
