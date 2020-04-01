;A 	= 	VALOR	CMP #VALOR 	BEQ 
;A 	<> 	VALOR 	CMP #VALOR 	BNE 
;A 	>= 	VALOR 	CMP #VALOR 	BCS
;A 	> 	VALOR 	CMP #VALOR 	BEQ y luego BCS 
;A 	< 	VALOR 	CMP #VALOR 	BCC

	icl 'BASE/hardware.asm'
	org $2000


;Activa pantalla de titulos
inicio
    mwa #pant_principal SDLSTL
	mwa #>font CHBAS
;color diaply dibujo principal
	MVA #$44 COLOR0		;$55
	mva #$c8 color1		;aa

;Lee botón Joystick
lee_boton
	lda STRIG0
	beq jugar
	jmp lee_boton

;Activa pantalla del juego
jugar
    mwa #pant_juego SDLSTL
	ldx #4
pon_colores
	lda colores_juego,x
	sta COLOR0,x
	dex
	bpl pon_colores

;Lee tecla de consola SELECT
leeconsola1
	lda CONSOL
	cmp #5
	beq salir
	jmp leeconsola1
salir
	jmp inicio



;-----------------------------------------
; Diseno de pantallas 
;-----------------------------------------
; La pantalla se estructura de la siguiente
; manera
; creadores en $46
; dibujo de 80 columnas por 40 en $4E
; nivel en $46
; mensaje start en $46
;
pant_principal
:3	.by $70
	.by $46
	.wo nombre_principal
:4	.by $70
	.by $4E
	.wo dibujo_principal
:79	.by $0E
	.by $70
	.by $46
	.wo teclas_principal
	.by $70
	.by $06
	.by $41
	.wo pant_principal

; textos en la pantalla de titulos
nombre_principal
	.sb +128,"by dogdark & ascrnet"

dibujo_principal
		.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$a0,$0,$0,$0,$0,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2a,$aa,$aa,$0,$2a,$aa,$aa,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0a,$0,$aa,$aa,$5a,$2,$aa,$aa,$aa,$6a,$aa,$80,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2a,$aa,$2,$95,$55,$55,$a2,$95,$55,$55,$6a,$aa,$aa,$aa,$80,$0,$0,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0a,$aa,$aa,$5a,$aa,$55,$55,$55,$a2,$95,$55,$55,$5a,$55,$6a,$aa,$a0,$0,$0,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2,$aa,$aa,$95,$55,$aa,$55,$56,$55,$68,$a5,$55,$95,$5a,$55,$55,$55,$aa,$80,$0,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2a,$a5,$55,$55,$55,$aa,$95,$5a,$95,$68,$a5,$56,$aa,$5a,$55,$55,$55,$6a,$aa,$80,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$aa,$a9,$55,$55,$55,$55,$68,$a5,$5a,$95,$5a,$29,$56,$aa,$5a,$55,$55,$55,$65,$6a,$aa,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2a,$aa,$a5,$55,$55,$5a,$55,$68,$a5,$5a,$a5,$5a,$29,$56,$82,$9a,$56,$55,$55,$59,$55,$6a,$aa,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2,$a9,$5a,$a5,$5a,$a5,$5a,$95,$58,$a5,$5a,$25,$5a,$29,$56,$80,$9a,$5a,$95,$55,$5a,$55,$55,$aa,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0a,$95,$5a,$29,$5a,$a5,$5a,$95,$5a,$29,$5a,$25,$5a,$29,$56,$80,$aa,$5a,$95,$6a,$5a,$55,$55,$55,$a0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$2,$a8,$a9,$55,$5a,$2a,$5a,$a5,$52,$95,$5a,$29,$5a,$25,$5a,$29,$56,$aa,$aa,$5a,$95,$6a,$5a,$95,$59,$55,$a0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0a,$aa,$a9,$55,$68,$0a,$5a,$a5,$52,$95,$5a,$29,$5a,$25,$5a,$0a,$56,$a6,$8a,$6a,$95,$6a,$56,$95,$6a,$95,$a0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$29,$56,$59,$55,$68,$0a,$5a,$a5,$52,$95,$5a,$29,$56,$25,$5a,$0a,$56,$a5,$a2,$a2,$95,$6a,$56,$95,$6a,$a5,$68,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$a5,$55,$5a,$55,$68,$0a,$5a,$a5,$52,$95,$5a,$29,$56,$a5,$5a,$0a,$56,$a5,$a0,$80,$a5,$5a,$56,$95,$68,$29,$68,$0
	.BY $0,$0,$0,$0a,$a0,$0,$0,$0,$0,$0,$0,$2,$95,$55,$5a,$95,$68,$0a,$5a,$a9,$52,$95,$68,$29,$56,$95,$68,$0a,$55,$a5,$a0,$0,$a5,$5a,$aa,$a5,$68,$0a,$68,$0
	.BY $0,$0,$0,$aa,$aa,$0,$0,$0,$0,$0,$20,$0a,$55,$55,$5a,$95,$68,$0a,$5a,$a9,$5a,$95,$68,$29,$55,$55,$68,$0a,$55,$55,$a0,$0,$a5,$5a,$28,$a5,$68,$aa,$68,$0
	.BY $0,$0,$0,$a5,$5a,$0,$0,$0,$0,$aa,$a8,$0a,$55,$a5,$56,$95,$68,$0a,$56,$a9,$56,$95,$a0,$29,$55,$55,$68,$0a,$55,$55,$a0,$0,$a5,$5a,$0,$a5,$68,$aa,$a0,$0
	.BY $0,$0,$2,$95,$56,$80,$0,$0,$0a,$aa,$9a,$29,$5a,$a9,$56,$95,$68,$2,$96,$a9,$55,$55,$a0,$29,$55,$55,$6a,$0a,$55,$65,$68,$0,$a5,$5a,$0,$a5,$5a,$9a,$a0,$0
	.BY $0,$0,$2,$95,$55,$a0,$0,$0,$2a,$55,$5a,$29,$5a,$29,$56,$95,$68,$2,$96,$a9,$55,$55,$a8,$0a,$55,$95,$56,$82,$95,$69,$68,$0,$a5,$5a,$0,$a5,$5a,$9a,$0,$0
	.BY $0,$0,$2,$95,$55,$a0,$0,$0,$a5,$55,$56,$a5,$68,$0a,$56,$95,$68,$2,$96,$a9,$55,$55,$5a,$0a,$55,$a5,$56,$82,$95,$6a,$68,$0,$a5,$56,$80,$29,$56,$96,$80,$0
	.BY $0,$0,$2,$95,$55,$68,$0,$0,$a5,$55,$56,$a5,$68,$0a,$5a,$95,$68,$2,$96,$a9,$56,$95,$5a,$0a,$55,$a9,$55,$a2,$95,$6a,$68,$0,$29,$56,$80,$29,$55,$56,$80,$0
	.BY $0,$0,$2,$95,$55,$68,$0,$2,$95,$6a,$56,$a5,$68,$2,$9a,$95,$68,$2,$96,$a9,$56,$a5,$56,$8a,$55,$a9,$55,$a2,$95,$6a,$68,$80,$29,$56,$80,$29,$55,$56,$80,$0
	.BY $0,$0,$2,$95,$55,$5a,$0,$2,$95,$aa,$96,$a5,$68,$2,$aa,$95,$68,$2,$96,$a9,$56,$a5,$56,$8a,$55,$a9,$55,$a2,$95,$6a,$aa,$a8,$29,$56,$80,$29,$56,$96,$80,$0
	.BY $0,$0,$2,$95,$55,$5a,$0,$0a,$55,$a0,$a6,$95,$68,$0,$aa,$95,$68,$2,$96,$a9,$56,$a9,$55,$aa,$55,$aa,$55,$6a,$95,$6a,$aa,$68,$29,$56,$80,$29,$56,$a5,$a0,$0
	.BY $0,$0,$2,$95,$55,$5a,$0,$0a,$55,$a0,$2a,$95,$68,$0,$2,$95,$68,$2,$96,$a9,$56,$a9,$55,$aa,$55,$a2,$55,$6a,$95,$68,$0a,$5a,$29,$55,$a0,$0a,$56,$a9,$a0,$0
	.BY $0,$0,$2,$95,$55,$56,$80,$0a,$55,$a8,$0a,$95,$68,$0,$2,$95,$68,$2,$96,$a9,$56,$89,$55,$aa,$55,$a2,$55,$6a,$95,$68,$0a,$5a,$29,$55,$a0,$0a,$56,$a9,$a0,$0
	.BY $0,$0,$2,$95,$55,$56,$80,$0a,$55,$6a,$80,$95,$68,$0,$2,$95,$5a,$2,$96,$a9,$56,$89,$55,$aa,$55,$62,$55,$6a,$95,$5a,$aa,$5a,$29,$55,$a0,$0a,$55,$aa,$80,$0
	.BY $0,$0,$2,$95,$55,$56,$80,$0a,$55,$5a,$a0,$95,$68,$0,$2,$95,$5a,$2,$96,$a9,$55,$8a,$55,$6a,$55,$62,$95,$5a,$95,$5a,$aa,$5a,$29,$55,$a8,$0a,$55,$a2,$82,$a0
	.BY $0,$0,$2,$95,$55,$55,$a0,$0a,$55,$55,$68,$95,$5a,$0,$2,$95,$5a,$2,$96,$a9,$55,$8a,$55,$6a,$55,$6a,$95,$56,$95,$55,$55,$5a,$29,$55,$6a,$0a,$55,$a0,$0a,$a0
	.BY $0,$0,$2,$95,$55,$55,$a0,$0a,$55,$55,$5a,$95,$5a,$0,$2a,$a5,$5a,$0a,$56,$a9,$55,$aa,$55,$59,$55,$5a,$95,$56,$95,$55,$55,$5a,$a5,$55,$5a,$0a,$55,$a0,$0a,$68
	.BY $0,$0,$2,$95,$55,$55,$a0,$0a,$55,$55,$56,$95,$5a,$0,$2a,$a5,$56,$aa,$56,$a9,$55,$6a,$55,$59,$55,$58,$a5,$56,$95,$55,$55,$5a,$a5,$55,$56,$8a,$55,$68,$29,$68
	.BY $0,$0,$2,$95,$55,$55,$68,$0a,$55,$55,$55,$95,$56,$0,$a6,$a5,$55,$a9,$5a,$a5,$55,$62,$95,$5a,$55,$58,$a9,$56,$aa,$aa,$aa,$5a,$29,$55,$56,$8a,$55,$6a,$a9,$68
	.BY $0,$0,$2,$95,$55,$55,$68,$0a,$55,$55,$55,$95,$56,$a2,$a6,$a5,$55,$55,$5a,$a5,$55,$60,$a5,$5a,$aa,$a8,$2a,$aa,$aa,$aa,$aa,$a8,$2a,$a5,$56,$8a,$55,$56,$a9,$5a
	.BY $0,$0,$2,$95,$55,$55,$68,$2,$95,$55,$55,$95,$55,$aa,$96,$a5,$55,$55,$68,$a5,$55,$a0,$2a,$a8,$aa,$a0,$0a,$a8,$0,$0,$0,$a0,$2,$aa,$aa,$82,$95,$55,$55,$5a
	.BY $0,$0,$0a,$56,$95,$55,$68,$2,$95,$55,$55,$a5,$55,$69,$56,$a9,$55,$55,$a8,$2a,$aa,$80,$0a,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0a,$a8,$0,$aa,$a5,$55,$5a
	.BY $0,$0,$0a,$56,$95,$55,$5a,$0,$a5,$55,$55,$a5,$55,$55,$5a,$aa,$55,$56,$a0,$0a,$aa,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$aa,$aa,$a9,$5a
	.BY $0,$0,$0a,$56,$a5,$55,$5a,$0,$aa,$55,$55,$a5,$55,$55,$5a,$a0,$95,$5a,$80,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0a,$aa,$aa
	.BY $0,$0,$0a,$5a,$a5,$55,$5a,$2,$0a,$a5,$55,$a9,$55,$55,$a8,$2,$aa,$a8,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0a,$a0
	.BY $0,$0,$0a,$5a,$a5,$55,$5a,$0a,$a0,$a9,$56,$a9,$55,$55,$a8,$0,$aa,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$0a,$5a,$29,$55,$56,$a9,$a0,$29,$56,$8a,$55,$56,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$29,$5a,$29,$55,$56,$a9,$68,$29,$56,$8a,$95,$5a,$80,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$29,$68,$29,$55,$56,$a9,$6a,$a9,$5a,$82,$aa,$aa,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$29,$68,$29,$55,$56,$a9,$5a,$a5,$5a,$0,$aa,$a8,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$29,$68,$29,$55,$55,$a9,$56,$95,$68,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$a5,$68,$a9,$55,$55,$a9,$55,$55,$a8,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$a5,$6a,$a5,$55,$55,$a9,$55,$56,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$a5,$6a,$55,$55,$55,$aa,$55,$5a,$80,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$a5,$55,$55,$55,$55,$6a,$a6,$aa,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$a5,$55,$55,$55,$55,$68,$aa,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$2,$95,$55,$55,$55,$55,$68,$8,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$2,$95,$55,$55,$55,$55,$6a,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$2,$95,$55,$55,$55,$55,$5a,$80,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0a,$55,$55,$6a,$55,$55,$55,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0a,$55,$56,$aa,$55,$55,$55,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0a,$55,$6a,$8a,$55,$55,$55,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0a,$55,$a0,$0a,$55,$55,$55,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0a,$56,$a0,$0a,$55,$55,$56,$80,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$29,$5a,$80,$0a,$55,$55,$5a,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$29,$5a,$0,$29,$55,$55,$68,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$29,$5a,$0,$a5,$55,$55,$a8,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$29,$5a,$0,$a5,$55,$5a,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$a5,$5a,$a0,$a5,$55,$aa,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$a5,$5a,$a0,$a5,$6a,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$a5,$55,$a0,$2a,$aa,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $2,$95,$55,$a0,$0a,$80,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $2,$95,$55,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0a,$55,$56,$80,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0a,$55,$56,$80,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $29,$55,$5a,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $a5,$55,$6a,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $a5,$55,$a8,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $a5,$5a,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $a5,$aa,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $aa,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $aa,$a0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.BY $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0


teclas_principal
	.sb "      NIVEL 00      "
	.sb "  BOTON PARA JUGAR  "

; Pantalla del juego 
pant_juego
:3	.by $70
	.by $44
	.wo nivel0
:22	.by 04
	.by $20
	.by $46
	.wo barra_puntaje
	.by $41 
	.wo pant_juego	


; textos de la pantalla del juego
barra_puntaje
	.sb "SC:0000000 T:50 L:03"

nivel0
	ins "nivel0.map"

; Colores del juego
;---------------------------------------
colores_juego
	.by $8e,$88,$84,$36

; Zona de Memoria para cambiar el FONT
; y se agrega el archivo fnt
;---------------------------------------
	org $4000
font
	ins "fuente.fnt"

    run inicio