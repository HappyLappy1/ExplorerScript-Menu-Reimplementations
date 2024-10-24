; ------------------------------------------------------------------------------
; Indexed Variable Full Copy
; Copies all the indices of one script variable to the other!
; 
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
.definelabel GetNbItemsInBag, 0x200EDFC
.definelabel GetItemAtIdx, 0x200F348
.definelabel IsThrownItem, 0x200CB10
.definelabel GetGameVar, 0x0204B4EC
.definelabel SetGameVar, 0x0204B820
.definelabel CountItemTypeInStorage, 0x200FEE4


; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel GetNbItemsInBag, 0x200EEA4
;.definelabel GetItemAtIdx, 0x200F3F0
;.definelabel IsThrownItem, 0x200CB98
;.definelabel GetGameVar, 0x0204B824
;.definelabel SetGameVar, 0x0204BB58
;.definelabel CountItemTypeInStorage, 0x200FF8C


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		sub r13,r13,#0x10
		push r8
		mov r0,#0
		mov r1,r7
		bl GetGameVar
		mov r8,r0
        bl GetNbItemsInBag;
        push r9-r10;
        cmp r0, #0;
        beq return;
        mov r9, r0;
        mov r10, #0;
        begin_loop: ;Loop over r10
            mov r0, r10;
            bl GetItemAtIdx;
            ldrh r0,[r0,#0x4]; This takes the item ID out of r1. 
            bl IsThrownItem;
            cmp r0, #1;
            beq has_throwable_item;
            ; If yes, return r0 as 255 or smthn. If no, continue the loop
            add r10, #1;
            cmp r10, r9;
            beq not_has_throwable_item;
            b begin_loop;

        has_throwable_item:
            mov r0, #255; Put 255 in r0
            b return;
        not_has_throwable_item:
            mov r0, r9; Put the actual item count in r0
            b return;

        return:
		    mov r8,r0;
            mov r2,r0;
            mov r0,#0;
		    mov r1,r7;
		    bl SetGameVar;
            mov r0,r8;
            pop r8-r10
		    add r13,r13,#0x10
		    b ProcJumpAddress
		    .pool
	.endarea
.close
