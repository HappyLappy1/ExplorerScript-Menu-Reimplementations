.relativeinclude on
.nds
.arm
; ------------------------------------------------------------------------------
; Set Starter with Var By Happylappy
; Assigns a starter of the specified ID to either the hero or partner:
; Param 1: Species ID of the pokemon you want to set for the starter
; Param 2: 0 for hero, 1 for partner
; Original by Adex... or Hecka... or Irdkwia... Can one of you claim this please?
; ------------------------------------------------------------------------------

; Uncomment/comment the following labels depending on your version.

; for US
.definelabel MaxSize, 0x810
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel DEFAULT_HERO_ADDR, 0x20AFEFC
.definelabel DEFAULT_PARTNER_ADDR, 0x20AFEFE
.definelabel GetGameVar, 0x0204B4EC
.definelabel SetGameVar, 0x0204B820

; for EU
;.definelabel MaxSize, 0x810
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel DEFAULT_HERO_ADDR, 0x20B0818
;.definelabel DEFAULT_PARTNER_ADDR, 0x20B081A
;.definelabel GetGameVar, 0x0204B824
;.definelabel SetGameVar, 0x0204BB58


.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		push r8
		mov r0,#0
		mov r1,r7
		bl GetGameVar
		mov r8,r0
		cmp    r6,#0
        ldreq  r1,=DEFAULT_HERO_ADDR
        ldrne  r1,=DEFAULT_PARTNER_ADDR
		strh   r8,[r1,#0x0]
        mov    r0,r8
        pop r8
		b ProcJumpAddress
		.pool
	.endarea
.close
