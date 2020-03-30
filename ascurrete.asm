;A 	= 	VALOR	CMP #VALOR 	BEQ 
;A 	<> 	VALOR 	CMP #VALOR 	BNE 
;A 	>= 	VALOR 	CMP #VALOR 	BCS
;A 	> 	VALOR 	CMP #VALOR 	BEQ y luego BCS 
;A 	< 	VALOR 	CMP #VALOR 	BCC

	icl 'BASE/hardware.asm'
    org $2000


;Activa pantalla de titulos
inicio
    mwa #pant_titulos SDLSTL

;Lee tecla de consola START
leeconsola
	lda CONSOL
	cmp #6
	beq jugar
	jmp leeconsola

;Activa pantalla del juego
jugar
    mwa #pant_juego SDLSTL

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
; Pantalla de titulos 
pant_titulos
:3	.by $70
	.by $46
	.wo nombre_juego
:2	.by $70
	.by $06
:4	.by $70
	.by $46
	.wo autores
	.by $06
:5	.by $70
	.by $46
	.wo teclas
	.by $41
	.wo pant_titulos

; textos en la pantalla de titulos
nombre_juego
	.sb "by dogdark & ascrnet"
	.sb "   -- ASCURRETE --  "
autores
	.sb "        2020        "
	.sb "       ascrnet      "
teclas
	.sb "   presione start   "


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
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "
:40 .sb " "

    run inicio