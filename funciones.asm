;-----------------------------
; Función de pausa
;----------------------------

.macro pausa
	ift :0 == 0
		lda:cmp:req 20
	els
		lda RTCLOK
		add #:1
		cmp 20
		bne *-2
	eif
.endm
