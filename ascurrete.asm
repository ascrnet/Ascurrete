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
; dibujo de 80 columnas por 40 en $4d
; nivel en $46
; mensaje start en $46
;
pant_principal
:3	.by $70
	.by $46
	.wo nombre_principal
:4	.by $70
	.by $4d
	.wo dibujo_principal
:40	.by $0d
:4	.by $70
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
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00
:40	.by $00

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