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

;-------------------------------------
; Limpia variable de puntaje
;-------------------------------------
.proc limpia_puntaje
	lda #0
	ldx #6
limpia_puntaje
	sta puntaje,x
	dex
	bpl limpia_puntaje
	rts
.endp

;--------------------------------------
; Actualiza el puntaje de 1 en 1
; pero se ve en pantalla de 10 en 10
;--------------------------------------
.proc actualiza_puntaje
	ldx #5
digito2
	lda puntaje,x 
	add #1
	cmp #10
	bne digito1
	mva #0 puntaje,x 
	dex
	jmp digito2
digito1 
	sta puntaje,x 
	
; Actuliza la pantalla
	ldx #6
act_puntaje
	lda puntaje,x
	ora #$10
	sta barra_puntaje+2,x
	dex
	bpl act_puntaje
	rts
.endp