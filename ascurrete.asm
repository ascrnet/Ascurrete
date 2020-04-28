;A 	= 	VALOR	CMP #VALOR 	BEQ 
;A 	<> 	VALOR 	CMP #VALOR 	BNE 
;A 	>= 	VALOR 	CMP #VALOR 	BCS
;A 	> 	VALOR 	CMP #VALOR 	BEQ y luego BCS 
;A 	< 	VALOR 	CMP #VALOR 	BCC

	icl "BASE/hardware.asm"
	icl "variables.asm"
	icl "funciones.asm"

	org $2000

;Inicio del juego
inicio
;reseteamos nivel a 0
	mva #0 direc_arco
	mva #0 RTCLOK
	jsr reseter_nivel
	mwa #>font CHBAS
	limpia_puntaje
;Activa pantalla de titulos
titulos
	mwa #pant_principal SDLSTL
	ldx #2
pongo_color_portada
	lda colores_pantalla,x
	sta COLOR0,x
	dex
	bpl pongo_color_portada 



;---------------------------------------
; opcion 
; si es select aunmentamos el nivel
; si es boton enviamos a jugar
;---------------------------------------
opcion_inicio
	arcoiris
	lda CONSOL
;si es select viajo a opcion_inicio2
	cmp #5
	beq opcion_inicio2
	cmp #6
	beq opcion_inicio3
;lee joystick
	lda STRIG0
	beq jugar
	jmp opcion_inicio
opcion_inicio2
;si suelto select continuo
	arcoiris
	lda consol
	cmp #5
	beq opcion_inicio2
;sumo un nivel
	jsr sumo_nivel
;imprimo en pantalla el nuevo valor de nivel
	lda puntero_nivel+1
	sta nivel_principal+1
	lda puntero_nivel
	sta nivel_principal
	jmp opcion_inicio
opcion_inicio3
	arcoiris
;valido si se suelta start
	lda consol
	cmp #6
	beq opcion_inicio3

;---------------------------------------
;Activa pantalla del juego
;---------------------------------------
jugar
	mwa #pant_juego SDLSTL
	mwa #dli VDSLST
	mva #192 NMIEN
	ldx #3
pon_color_g
	lda colores_juego,x
	sta COLOR0,x
	dex
	bpl pon_color_g

;--------------------------------------
; validamos las niveles
;---------------------------------------
veo_pantallas
	veo_cuadros
	actualiza_puntaje
	jmp*
fin_niveles
	jmp * 

;---------------------------------------
;Active PM
;---------------------------------------
	mva #>PMDIR PMBASE
	mva #3 GRACTL
	mva #62 SDMCTL
	mva #34 GPRIOR

	pone_pelota 10 5
	mva #$c4 PCOLR0
	mva #$cc PCOLR0+1

	lda #$07	
	ldx #>vbd
	ldy #<vbd
	jsr SETVBV

;--------------------------------------
;Lee el Joystick
;--------------------------------------
lee_joy
	lda #0
	sta HITCLR
	sta ATRACT
	lda STICK0
	lsr
	bcs no_arriba
	jmp mover_arriba
no_arriba
	lsr
	bcs no_abajo
	jmp mover_abajo
no_abajo
	lsr
	bcs no_izquierda
	jmp mover_izquierda	
no_izquierda
	lsr
	bcs no_derecha
	jmp mover_derecha	
no_derecha
	jmp lee_joy

;--------------------------------------
;Mover la pelota según la direccion
;leida del Joystick
;--------------------------------------
mover_arriba
	dec pelota_y
	pausa
	lda P0PF
	bne stop_arriba	
	lda pelota_y
	cmp #40
	bne mover_arriba
	pone_pelota 10 5
	jmp vuelve_leer
stop_arriba
	inc pelota_y
	inc pelota_y
	jmp vuelve_leer
mover_abajo
	inc pelota_y
	pausa
	lda P0PF
	bne stop_abajo
	lda pelota_y
	cmp #200
	bne mover_abajo
	pone_pelota 10 5
	jmp vuelve_leer
stop_abajo
	dec pelota_y
	dec pelota_y
	jmp vuelve_leer
mover_izquierda
	dec pelota_x
	pausa
	lda P0PF
	bne stop_izquierda
	lda pelota_x
	cmp #40	
	bne mover_izquierda
	pone_pelota 10 5
	jmp vuelve_leer
stop_izquierda
	inc pelota_x
	inc pelota_x
	jmp vuelve_leer
mover_derecha
	inc pelota_x
	pausa
	lda P0PF
	bne stop_derecha
	lda pelota_x
	cmp #200
	bne mover_derecha
	pone_pelota 10 5
	jmp vuelve_leer
stop_derecha
	dec pelota_x
	dec pelota_x	
vuelve_leer
	jmp lee_joy

;---------------------------------------
;Lee tecla de consola SELECT
;---------------------------------------
leeconsola1
	lda CONSOL
	cmp #5
	beq salir
	jmp leeconsola1
salir
	jmp titulos

;-----------------------------------------
;Rutina VBD para el movimiento 
;de la pelota en la pantalla
;-----------------------------------------
vbd
	ldx #$00
	txa
limpia_pm
	sta PLAYER_0,x
	sta PLAYER_1,x
	inx
	bne limpia_pm
	ldx pelota_y
	ldy #$00
lee_datos_pm0
	lda pelota0,y
	sta PLAYER_0,x
	iny	
	inx			
	cpy #8
	bne lee_datos_pm0
	ldx pelota_y
	ldy #$00
lee_datos_pm1
	lda pelota1,y
	sta PLAYER_1,x
	iny
	inx			
	cpy #5
	bne lee_datos_pm1
	lda pelota_x
	sta HPOSP0
	sta HPOSP1
	jmp XITVBV

;----------------------------------------
; Diseño de Player y Misiles
; pelota PM0 y PM1
;----------------------------------------
pelota0
	dta %00111100
	dta %01111110
:4	dta %11111111
	dta %01111110
	dta %00111100

pelota1
	dta %00000000
	dta %00011000
	dta %00100000
:2	dta %01000000

;-----------------------------------------
; Diseño de pantallas 
;-----------------------------------------
; La pantalla se estructura de la siguiente
; manera
; creadores en $46
; dibujo de 80 columnas por 40 en $4E
; nivel en $46
; mensaje start en $46
pant_principal
:3	.by $70
	.by $46
	.wo editores
	.by $4d
	.wo dibujo_principal
:79	.by $0d
:2	.by $06
	.by $41
	.wo pant_principal

;---------------------------------------
; Pantalla del juego 
;---------------------------------------
pant_juego
:3	.by $70
	.by $44
	.wo pant_puzzle
:21	.by 04
	.by $20+$80
	.by $20
	.by $46
	.wo barra_puntaje
	.by $41 
	.wo pant_juego	

;---------------------------------------
; textos de la pantalla del juego
;---------------------------------------
barra_puntaje
	.sb "0000000  "
	.by $ae
nivel_juego
	.sb "00 "
	.by $be
	.sb "50 "
	.by $bf
	.sb "03"

;---------------------------------------
; Dli para la barras de puntaje
;---------------------------------------
dli
	phr
	ldx #$0
ndli
	lda dli_color,x
	sta WSYNC
	sta COLBK	
	inx
	cpx #14
	bne ndli
	plr
	rti	

dli_color
	.by +$1,9,2,2,2,2,2,2,2,2,2,2,2,9,0

;---------------------------------------
; Colores del juego
;---------------------------------------
colores_juego
	.by $8e,$88,$84,$36
colores_pantalla
	.by $38,$6,$f 
;	.by 14,180,50
	
;---------------------------------------
; bytes de dibujo de portada
;---------------------------------------
editores
	.sb " ASCRNET & DOGDARK  "*
dibujo_principal
	icl "portada.asm"
	.sb " SELECT - NIVEL "*
nivel_principal	
	.sb "00  "
	.sb "START BOTON - JUEGA "*

sumo_nivel
	ldx nivel
	inx
	stx nivel
	cpx #16
	beq reseter_nivel
	lda puntero_nivel+1
	cmp #$19
	beq sumonivel9
	clc
	lda puntero_nivel+1
	adc #$1
	sta puntero_nivel+1
	rts
sumonivel9
	lda #$10
	sta puntero_nivel+1
	lda puntero_nivel
	cmp #$19
	beq sumonivel29
	clc
	lda puntero_nivel
	adc #$1
	sta puntero_nivel
	rts
sumonivel29
	lda #$10
	sta puntero_nivel
	rts
reseter_nivel
	lda #0
	sta nivel
	lda #$10
	sta puntero_nivel
	sta puntero_nivel+1
	rts

;---------------------------------------
; Zona de memoria para el Puzzle
;---------------------------------------
	org $4000
	icl "niveles.asm"

;---------------------------------------
; Zona de Memoria para cambiar el FONT
; y se agrega el archivo fnt
;---------------------------------------
	org $A000
font
	ins "fuente.fnt"

    run inicio