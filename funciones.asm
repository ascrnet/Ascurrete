;-----------------------------
; Función de pausa
;----------------------------
.macro pausa
	ift :0 == 0
		lda:cmp:req RTCLOK
	els
		lda RTCLOK
		add #:1
		cmp 20
		bne *-2
	eif
.endm

.macro arcoiris
arco
	lda $d40b
	clc
	adc 20
	sta $d40a
	sta $d01a
	jmp arco
.endm

;--------------------------------------
; Calcula pixiles por caracteres
;--------------------------------------
.macro  pone_pelota (x,y)
	mva #:x*8+48 pelota_x
	mva #:y*16+36 pelota_y
.endm

;--------------------------------------
; Borra puzzle en la pantalla
;-------------------------------------
.proc limpia_puzzle
	lda #0 ; espacio en blanco
	ldx #0
limpiar
	sta pant_puzzle,x
	sta pant_puzzle+$100,x
	sta pant_puzzle+$200,x
	sta pant_puzzle+$300,x
	dex
	bne limpiar
	rts
.endp