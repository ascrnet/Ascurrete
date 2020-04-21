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
	sta barra_puntaje+1,x
	dex
	bpl act_puntaje
	rts
.endp

;------------------------------
; Calcula los objectos 
; del nivel
;------------------------------
.proc crea_nivel
	mva #0 xsur
	mva #0 ysur
	mva #4 idx 
crea	
	ldx idx
	lda nivel_temp,x
	cmp #' '
	beq obj1
	cmp #'1'
	beq obj2
	cmp #'2'
	beq obj3
	cmp #'3'
	beq obj4
	cmp #'4'
	beq obj5
    jmp *
obj1
	mva #0 temp2
	jmp obj_fin
obj2 
	mva #1 temp2
	jmp obj_fin
obj3
	mva #2 temp2
	jmp obj_fin
obj4
	mva #3 temp2
	jmp obj_fin
obj5
	mva #4 temp2

obj_fin
	pant_objectos
	inc xsur
	lda xsur
	cmp #20
	beq xlinea
	add16 temp1 #2
	inc idx
	jmp crea
	
xlinea	
	add16 temp1 #2*40-19*2 
	inc idx
	mva #0 xsur
	inc ysur
	lda ysur
	cmp #11
	jne crea

xsur	
	.by 0
ysur	
	.by 0
idx		
	.by 0
.endp

;-----------------------------
; Pinta objectos en pantalla
; 2x2
;-----------------------------
.proc pant_objectos
	lda temp2
	asl
	asl
	tax
	ldy #0
	lda objectos,x
	sta (temp1),y
	iny
	inx
	lda objectos,x
	sta (temp1),y
	ldy #40
	inx
	lda objectos,x
	sta (temp1),y
	iny
	inx
	lda objectos,x
	sta (temp1),y
	rts

; Diseño de objectos 2x2 caracteres
objectos
	.by $0,$0,$0,$0     ; espacios 
    .by $40,$41,$42,$43 ; cuadrado
	.by $40,$41,$44,$45 ; linea vertical parte 1
	.by $44,$45,$44,$45 ; Linea vertical parte 2
	.by $44,$45,$42,$43 ; Linea vertical parte 3
.endp

;----------------------------------
; Suma 16 bytes
;----------------------------------
.macro	add16
	lda :1
	add :2
	sta :1
	bcc exitadd
	inc :1+1
exitadd	
.endm
;----------------------------------
; muestro nivel de juego
;----------------------------------
.proc muestro_nivel_juego
	lda puntero_nivel+1
	sta nivel_juego+1
	lda puntero_nivel
	sta nivel_juego
	rts
.endp
;----------------------------------
; obtiene data para colocar 
; cuadrados en la pantalla
;----------------------------------
.macro veo_cuadros
	lda nivel
	asl
	tax
	lda niveles,x
	sta temp1
	lda niveles+1,x
	sta temp1+1
	ldy #0
copy  
	mva (temp1),y nivel_temp,y+
	cpy #.len nivel_temp
	bne copy
	mwa #pant_puzzle temp1
	crea_nivel
	muestro_nivel_juego
.endm
