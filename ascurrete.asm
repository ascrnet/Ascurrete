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
	mwa #>font CHBAS

;Activa pantalla de titulos
titulos
	mwa #pant_principal SDLSTL
	ldx #2
pongo_color_portada
	lda colores_pantalla,x
	sta COLOR0,x
	dex
	bpl pongo_color_portada 

;Lee botón Joystick
;---------------------------------------
lee_boton
	lda STRIG0
	beq jugar
	jmp lee_boton

;---------------------------------------
;Activa pantalla del juego
;---------------------------------------
jugar
	mwa #pant_juego SDLSTL
	ldx #3
pon_color_g
	lda colores_juego,x
	sta COLOR0,x
	dex
	bpl pon_color_g

;--------------------------------------
; pinta el nivel en la pantalla
;---------------------------------------
;	jmp * 

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
;
pant_principal
:3	.by $70
	.by $4d
	.wo dibujo_principal
:89	.by $0d
	.by $41
	.wo pant_principal
;---------------------------------------
; Pantalla del juego 
;---------------------------------------
pant_juego
:3	.by $70
	.by $44
	.wo pant_intermedia
:21	.by 04
	.by $30
	.by $46
	.wo barra_puntaje
	.by $41 
	.wo pant_juego	

;---------------------------------------
; textos de la pantalla del juego
;---------------------------------------
barra_puntaje
	.sb "  0000000   "
	.by $7e
	.sb "50 "
	.by $7f
	.sb "03 "
;---------------------------------------
; Colores del juego
;---------------------------------------
colores_juego
	.by $8e,$88,$84,$36
colores_pantalla
	.by $0e,$b4,$32	
;	.by 14,180,50
	
;---------------------------------------
; bytes de dibujo de portada
;
;---------------------------------------
dibujo_principal
	.by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $FF,$FF,$FF,$FF,$F,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$F3,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$CF,$FC,$3F,$FF,$FF,$FC
	.by $FF,$3F,$FF,$FF,$F,$FF,$FF,$FF,$FC,$3F,$FF,$FC,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$3C
	.by $F3,$FF,$FF,$FF,$F,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$3F,$FF,$C3,$FF,$FF,$FF,$FC,$F,$FC,$FF,$FC
	.by $FF,$FF,$FF,$FF,$F,$FF,$FF,$3F,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$CF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$F,$F0,$FF,$FC
	.by $FF,$FF,$3F,$FF,$F,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$CF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FC
	.by $FF,$FF,$FF,$FF,$F,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FC
	.by $FF,$FF,$FF,$FF,$F,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FC,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$CF,$FF,$FC,$3F,$FF,$FF,$FC
	.by $00,$00,$00,$00,$00,$00,$00,$00,$00,$5,$55,$55,$40,$00,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$A8
	.by $00,$00,$00,$00,$00,$00,$00,$00,$5,$55,$55,$55,$55,$40,$A,$AA,$AA,$AA,$AA,$AF,$EA,$AA,$BF,$FF,$AA,$BF,$FB,$FB,$FA,$FF,$FE,$AF,$FF,$EB,$FF,$FF,$FF,$FF,$FF,$FC
	.by $FF,$FC,$3F,$FF,$FF,$FF,$F0,$FD,$55,$55,$55,$55,$55,$55,$00,$AA,$AA,$AA,$AA,$BD,$FA,$AA,$F5,$5E,$AA,$B5,$7B,$7B,$7A,$D5,$5E,$AD,$55,$EB,$55,$55,$55,$55,$55,$54
	.by $FF,$FC,$3F,$FF,$FF,$FF,$F0,$55,$55,$55,$55,$55,$55,$55,$54,$2A,$AA,$AA,$AA,$F5,$7A,$AB,$DF,$FE,$AA,$D5,$7B,$7B,$7A,$DF,$F7,$AD,$FF,$7B,$7F,$FF,$DF,$FF,$7F,$FC
	.by $FF,$FC,$3F,$FF,$FF,$FF,$F1,$55,$55,$55,$55,$55,$55,$55,$55,$2,$AA,$AA,$AA,$F7,$7E,$AB,$9E,$AA,$AB,$7F,$FB,$7B,$7A,$DE,$B5,$ED,$EB,$5F,$7E,$AA,$DE,$AB,$7A,$A8
	.by $FF,$FC,$3F,$FF,$FF,$FF,$D5,$55,$55,$55,$55,$55,$55,$55,$55,$50,$AA,$AA,$AB,$DF,$5E,$AF,$7E,$AA,$AD,$FE,$AB,$7B,$7A,$DE,$BD,$ED,$EB,$DF,$7E,$AA,$DE,$AB,$7A,$A8
	.by $F3,$FC,$3F,$FF,$F3,$FF,$55,$55,$55,$55,$55,$55,$55,$55,$55,$54,$6,$AA,$AB,$5E,$5E,$AD,$FA,$AA,$B5,$EA,$AB,$7B,$7A,$DF,$F5,$ED,$EF,$5F,$7E,$AA,$DE,$AB,$7A,$A8
	.by $FF,$FC,$3F,$FF,$FF,$F5,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$41,$6A,$AF,$7A,$DE,$BD,$FF,$FF,$DE,$AA,$AF,$7B,$7A,$DF,$57,$AD,$F5,$7B,$7F,$FA,$DE,$AB,$7F,$F8
	.by $FF,$FC,$3F,$FF,$FF,$D5,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$50,$9A,$AD,$7F,$D7,$F5,$55,$57,$7E,$AA,$AD,$7B,$7A,$D5,$5E,$AD,$55,$EB,$55,$7A,$DE,$AB,$55,$78
	.by $FF,$FC,$3F,$FF,$FF,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$54,$A5,$BD,$55,$57,$FF,$FD,$7F,$7E,$AA,$AD,$7B,$7A,$DF,$57,$AD,$F5,$7B,$7F,$FA,$DE,$AB,$7F,$F8
	.by $00,$00,$00,$00,$1,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$40,$FF,$D7,$AA,$B5,$FB,$DE,$AA,$AD,$7B,$7A,$DF,$F5,$ED,$FF,$5B,$7A,$AA,$DE,$AB,$7A,$A8
	.by $00,$00,$00,$00,$5,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$40,$14,$AA,$D7,$AA,$F5,$EA,$DE,$AA,$AD,$7B,$7A,$DE,$BD,$ED,$EB,$DB,$7A,$AA,$DE,$AB,$7A,$A8
	.by $FF,$FF,$FF,$FF,$15,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$50,$9,$AA,$B5,$EB,$57,$EA,$DE,$AA,$AD,$7F,$7A,$DE,$AD,$ED,$EA,$DF,$7A,$AA,$DE,$AB,$7A,$A8
	.by $FF,$FF,$FF,$FF,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$54,$A,$6A,$B5,$FF,$7F,$AA,$DF,$FF,$ED,$7D,$7A,$DE,$AD,$ED,$EA,$DF,$7A,$AA,$DE,$AB,$7A,$A8
	.by $FF,$FF,$FF,$FF,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$54,$A,$96,$AD,$F5,$7A,$AA,$F5,$55,$EF,$55,$FA,$DE,$AD,$ED,$EA,$DF,$7F,$FF,$DE,$AB,$7F,$FC
	.by $FF,$FF,$FF,$FD,$55,$55,$55,$15,$55,$15,$55,$55,$55,$55,$55,$55,$55,$55,$2,$A9,$AF,$FF,$FA,$AA,$B5,$57,$EB,$F5,$EA,$DE,$AD,$ED,$EA,$DF,$55,$57,$DE,$AB,$55,$5C
	.by $FF,$F0,$FF,$F5,$55,$55,$55,$45,$55,$15,$55,$55,$55,$55,$55,$55,$55,$55,$43,$FF,$5A,$AA,$AA,$AA,$BF,$FF,$AA,$BF,$AA,$FE,$AF,$EF,$EA,$FF,$FF,$FF,$FE,$AB,$FF,$FC
	.by $FF,$FF,$FF,$F5,$55,$55,$55,$51,$55,$15,$55,$55,$55,$55,$55,$55,$55,$55,$40,$3F,$F6,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$A8
	.by $FF,$FF,$FF,$D5,$55,$55,$55,$54,$54,$55,$55,$55,$55,$55,$55,$55,$55,$55,$50,$3F,$FD,$7F,$C3,$FF,$C0,$FC,$F,$F,$FF,$FF,$FF,$C3,$FC,$3F,$C0,$C,$3F,$FF,$FF,$F0
	.by $FF,$FF,$FF,$55,$55,$55,$55,$55,$14,$55,$55,$55,$55,$55,$55,$55,$55,$55,$54,$3F,$FF,$DF,$C3,$FF,$F0,$3F,$F,$F,$FF,$FC,$3F,$C3,$FC,$3F,$C0,$FC,$3F,$FF,$F3,$C0
	.by $00,$00,$00,$55,$55,$55,$55,$55,$40,$55,$55,$55,$55,$55,$55,$55,$55,$55,$54,$00,$00,$5,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $00,$00,$00,$55,$55,$55,$55,$54,$15,$15,$55,$55,$55,$55,$55,$55,$55,$55,$54,$00,$00,$00,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $FF,$FC,$3D,$55,$55,$55,$55,$41,$51,$45,$55,$55,$55,$55,$55,$55,$55,$55,$55,$F,$F,$FF,$D7,$FF,$F0,$FF,$F,$FF,$00,$3,$F3,$C0,$C,$30,$C0,$FF,$FC,$00,$00,$FC
	.by $FF,$FC,$3D,$55,$55,$55,$55,$15,$54,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$F,$F,$F3,$FD,$FF,$F0,$FF,$C,$00,$00,$3,$CF,$FF,$FC,$00,$C,$FF,$F0,$3F,$F,$FC
	.by $FF,$FC,$3D,$55,$55,$55,$55,$55,$55,$15,$55,$55,$55,$55,$55,$55,$55,$55,$55,$F,$F,$FF,$CF,$5F,$F0,$FF,$00,$00,$00,$00,$F,$FC,$00,$00,$3,$FF,$C0,$FF,$F,$FC
	.by $FF,$FC,$35,$55,$55,$55,$55,$55,$55,$55,$55,$55,$15,$55,$55,$55,$55,$55,$55,$43,$F,$FF,$CF,$F7,$F0,$C0,$00,$00,$00,$00,$00,$F0,$00,$30,$FF,$FF,$C3,$FF,$F,$FC
	.by $FF,$FC,$35,$55,$54,$15,$55,$55,$55,$55,$55,$50,$55,$55,$55,$55,$55,$55,$55,$43,$F,$F0,$F,$FD,$70,$00,$00,$00,$00,$00,$00,$00,$3,$F0,$FF,$FF,$C0,$3F,$F,$FC
	.by $FF,$FC,$35,$55,$55,$55,$55,$55,$55,$55,$55,$5,$55,$55,$55,$55,$55,$55,$55,$41,$F,$FC,$3,$FF,$D0,$00,$00,$00,$00,$00,$00,$00,$FF,$F0,$FF,$FF,$C0,$F,$F,$FC
	.by $FF,$FC,$35,$55,$51,$55,$51,$55,$54,$55,$50,$55,$55,$55,$55,$55,$55,$55,$55,$40,$5F,$FF,$C0,$3,$C4,$00,$00,$00,$00,$00,$00,$00,$FF,$F0,$FF,$FF,$C3,$3,$F,$FC
	.by $FF,$FC,$15,$55,$55,$00,$51,$55,$41,$15,$5,$55,$55,$55,$55,$55,$55,$55,$55,$50,$5,$FF,$F0,$00,$1,$40,$00,$00,$00,$00,$00,$00,$F,$F0,$FF,$FF,$3,$C0,$F,$FC
	.by $00,$00,$15,$51,$54,$00,$51,$55,$15,$10,$45,$55,$55,$55,$55,$55,$55,$55,$55,$50,$00,$50,$00,$00,$00,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $00,$00,$15,$55,$40,$00,$54,$55,$55,$45,$50,$55,$55,$55,$55,$55,$55,$55,$55,$50,$00,$5,$00,$00,$00,$5,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $FF,$FF,$D5,$55,$00,$00,$55,$55,$55,$45,$55,$15,$55,$55,$55,$55,$55,$55,$55,$50,$C3,$FF,$43,$00,$00,$00,$40,$00,$00,$00,$00,$00,$00,$3F,$FF,$F0,$F,$F0,$FF,$FC
	.by $FF,$FF,$D5,$55,$00,$00,$55,$55,$55,$51,$55,$41,$55,$55,$55,$55,$55,$55,$55,$50,$C0,$FF,$D7,$00,$00,$00,$14,$00,$00,$00,$00,$00,$00,$3F,$FF,$00,$3F,$FC,$3F,$CC
	.by $FF,$FF,$D5,$51,$40,$1,$55,$55,$55,$54,$15,$54,$55,$55,$55,$55,$55,$55,$55,$50,$FC,$F,$C1,$40,$00,$00,$1,$00,$00,$00,$00,$00,$00,$F,$00,$00,$3F,$FC,$3F,$FC
	.by $FF,$FF,$D5,$55,$50,$5,$55,$15,$55,$55,$41,$55,$55,$55,$55,$55,$55,$55,$55,$50,$FF,$00,$C0,$14,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3,$00,$C,$3F,$FC,$F,$FC
	.by $FF,$FF,$D5,$55,$54,$15,$54,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$50,$FF,$00,$00,$1,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3,$FC,$3F,$FF,$F,$FC
	.by $FF,$F3,$D5,$55,$51,$55,$15,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$50,$FF,$F0,$00,$00,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3F,$FC,$3F,$FF,$F,$FC
	.by $FF,$FF,$D5,$55,$54,$51,$55,$55,$54,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$50,$FF,$FF,$00,$00,$5,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3F,$FC,$3F,$FF,$C3,$FC
	.by $FF,$FF,$D5,$55,$55,$55,$55,$55,$54,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$50,$FF,$FF,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$00,$3F,$FC,$3F,$FF,$C3,$FC
	.by $00,$00,$5,$55,$55,$51,$55,$55,$55,$15,$55,$5,$55,$55,$55,$55,$55,$55,$55,$40,$00,$00,$00,$00,$00,$5,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $00,$00,$5,$55,$55,$55,$51,$55,$55,$15,$00,$55,$55,$55,$55,$55,$55,$55,$55,$40,$50,$00,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $FF,$FC,$35,$45,$55,$50,$54,$55,$55,$40,$55,$55,$55,$55,$55,$55,$55,$55,$55,$4F,$5,$5C,$00,$00,$00,$00,$4,$00,$00,$00,$00,$00,$00,$00,$F,$FF,$FF,$FF,$C,$3C
	.by $FF,$FC,$35,$55,$45,$55,$54,$55,$55,$45,$55,$55,$55,$55,$55,$55,$55,$55,$55,$4F,$F,$F5,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$F,$00,$FF,$FF,$F,$FC
	.by $FF,$FC,$3D,$55,$55,$55,$55,$15,$55,$51,$55,$55,$55,$55,$55,$55,$55,$55,$55,$3,$F,$F0,$15,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$F,$FC
	.by $FF,$FC,$3D,$55,$55,$55,$55,$15,$55,$51,$55,$55,$55,$55,$55,$55,$55,$55,$55,$F,$C,$00,$00,$15,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$F3,$FF,$F,$FC
	.by $FF,$FC,$3D,$55,$55,$55,$55,$45,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$F,$C,$00,$00,$00,$15,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3,$FC,$3F,$FF,$F,$FC
	.by $FF,$FC,$33,$55,$55,$55,$55,$45,$00,$55,$55,$55,$55,$55,$55,$55,$55,$55,$54,$3F,$C,$00,$00,$00,$00,$55,$00,$00,$00,$00,$00,$00,$00,$00,$3,$FF,$3F,$FC,$F,$FC
	.by $FF,$FC,$3F,$55,$55,$55,$55,$51,$55,$00,$5,$55,$55,$55,$55,$55,$55,$55,$54,$3F,$F,$F0,$00,$00,$00,$00,$50,$00,$00,$00,$00,$00,$00,$00,$3,$FF,$F,$C0,$F,$FC
	.by $FF,$FC,$3F,$55,$55,$55,$55,$51,$55,$55,$40,$00,$15,$55,$55,$55,$55,$55,$54,$3F,$F,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3,$FF,$C0,$3F,$F,$FC
	.by $00,$00,$00,$15,$55,$55,$55,$54,$55,$55,$41,$55,$40,$15,$55,$55,$55,$55,$50,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $00,$00,$00,$5,$55,$55,$55,$55,$15,$55,$41,$55,$55,$55,$55,$55,$55,$55,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $FF,$FF,$FF,$F5,$55,$55,$55,$55,$15,$55,$45,$55,$55,$55,$55,$55,$55,$55,$43,$FF,$C0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3,$FC,$3F,$F,$FF,$FC
	.by $FF,$FF,$FF,$FD,$55,$55,$55,$55,$45,$55,$45,$55,$55,$55,$55,$55,$55,$55,$F,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3,$FC,$3F,$F,$FF,$FC
	.by $FC,$FF,$FF,$FF,$55,$55,$55,$55,$45,$55,$51,$55,$55,$55,$55,$55,$55,$54,$3F,$C0,$F,$F0,$00,$00,$5,$55,$50,$00,$00,$00,$00,$00,$00,$00,$3,$FC,$3F,$F,$3F,$FC
	.by $FF,$FF,$FF,$FF,$55,$55,$55,$55,$51,$55,$51,$55,$55,$55,$55,$55,$55,$54,$3F,$FF,$FD,$55,$55,$55,$50,$00,$00,$00,$00,$00,$00,$00,$00,$00,$F,$FC,$3C,$F,$FF,$FC
	.by $FF,$FF,$F3,$FF,$15,$55,$55,$55,$51,$55,$51,$55,$55,$55,$55,$55,$55,$50,$3D,$55,$57,$CC,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3C,$3F,$FF,$FC
	.by $FF,$FF,$FF,$FF,$5,$55,$55,$55,$54,$55,$51,$55,$55,$55,$55,$55,$55,$40,$3F,$FF,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3F,$FF,$FC
	.by $FF,$FF,$FF,$FF,$D,$55,$55,$55,$54,$55,$55,$55,$55,$55,$55,$55,$55,$00,$3F,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3F,$FC,$3F,$FF,$FF,$FC
	.by $FF,$FF,$FF,$FF,$F,$55,$55,$55,$55,$15,$55,$55,$55,$55,$55,$55,$54,$FC,$3F,$FF,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3F,$FC,$3F,$FF,$FF,$FC
	.by $00,$00,$00,$00,$00,$15,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$50,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $00,$00,$00,$00,$00,$5,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$40,$00,$00,$00,$00,$00,$00,$00,$00,$1,$54,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $FF,$FC,$3F,$FF,$FF,$FF,$55,$55,$55,$55,$55,$55,$55,$55,$55,$54,$F,$FF,$FF,$FF,$F,$F,$C0,$00,$15,$54,$00,$00,$00,$00,$00,$00,$00,$00,$F,$FF,$FF,$FF,$F,$FC
	.by $FF,$F0,$3F,$FF,$FF,$FF,$D5,$55,$55,$55,$55,$55,$55,$55,$55,$50,$FF,$FF,$FF,$FF,$F,$FF,$F1,$55,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$C3,$FF,$FF,$FF,$F,$FC
	.by $FF,$F0,$3F,$FF,$FF,$FF,$F1,$55,$55,$55,$55,$55,$55,$55,$55,$00,$FF,$F3,$FF,$FF,$F,$D5,$54,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$C0,$FF,$FF,$C0,$F,$FC
	.by $FF,$F0,$3F,$FF,$FF,$FF,$F0,$55,$55,$55,$55,$55,$55,$55,$54,$30,$FF,$FF,$FF,$F5,$55,$7F,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$30,$F0,$3F,$F0,$3,$F,$FC
	.by $FF,$FC,$3F,$FF,$FF,$CF,$F0,$FD,$55,$55,$55,$55,$55,$55,$00,$F0,$FF,$FF,$55,$5C,$F,$FF,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$30,$FC,$3F,$00,$FF,$F,$FC
	.by $FF,$FC,$3F,$FF,$FF,$FF,$F0,$FF,$F5,$55,$55,$55,$55,$40,$3F,$F0,$F5,$55,$FF,$FC,$F,$FF,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$F0,$FC,$00,$00,$FF,$F,$FC
	.by $FF,$FC,$3F,$FF,$FF,$FF,$F0,$FF,$FF,$F5,$55,$55,$40,$F,$FF,$55,$5F,$FF,$FF,$FF,$F,$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$F0,$FF,$00,$C,$3F,$F,$FC
	.by $FF,$FC,$3F,$FF,$FF,$FF,$F0,$FF,$FF,$F0,$00,$00,$F,$FF,$55,$F0,$FF,$FF,$FF,$FF,$F,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FC,$3,$F,$FC
	.by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $FF,$FF,$FF,$FF,$F,$FC,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$FF,$C3,$FF,$FC,$3F,$F0,$3F,$FC
	.by $FF,$FF,$FF,$FF,$F,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$C0,$00,$00,$00,$00,$00,$F0,$FF,$C0,$FF,$FC,$3F,$FC,$F,$FC
	.by $FF,$DF,$F5,$7D,$5D,$5F,$5F,$75,$5D,$55,$FF,$D5,$5F,$D5,$FD,$5F,$55,$7C,$1F,$D5,$F7,$FF,$C3,$FF,$CF,$C0,$00,$00,$00,$00,$3F,$F0,$FF,$C0,$FF,$FC,$3F,$F3,$F,$FC
	.by $FF,$DF,$DF,$F7,$D,$F7,$5F,$77,$FC,$1F,$FF,$F7,$DF,$43,$77,$F7,$DF,$7C,$1F,$DF,$77,$DF,$C3,$F0,$00,$00,$FC,$00,$00,$F,$FF,$F0,$FF,$C0,$FF,$FC,$3F,$FF,$C3,$FC
	.by $FF,$77,$DF,$F7,$D,$F7,$77,$77,$FC,$1F,$FF,$F7,$F7,$43,$77,$FF,$DF,$DC,$77,$D3,$77,$DF,$C3,$C0,$00,$3,$FF,$F,$C0,$3F,$FF,$F0,$FF,$C3,$FF,$FC,$3F,$FF,$FC,$FC
	.by $FF,$77,$D5,$77,$D,$5F,$77,$75,$7C,$1F,$D5,$77,$F7,$43,$75,$5F,$DF,$DC,$77,$D5,$F5,$7F,$C3,$C0,$F,$FF,$FF,$F,$F0,$F,$F3,$F0,$FF,$C3,$FF,$FC,$3F,$FF,$FC,$3C
	.by $FD,$55,$FF,$77,$D,$F7,$77,$77,$FC,$1F,$FF,$F7,$F7,$43,$77,$F7,$DF,$DD,$55,$DF,$77,$5F,$C3,$3F,$FF,$F3,$FF,$F,$FF,$3,$FF,$F0,$FF,$C3,$FF,$FC,$3F,$FF,$FF,$C
	.by $FD,$FD,$FF,$77,$D,$F7,$7D,$77,$FC,$1F,$FF,$F7,$F7,$43,$77,$F7,$DF,$DD,$3D,$DF,$77,$DF,$C3,$FF,$FF,$FF,$FF,$F,$FF,$C0,$FF,$F0,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$C0
	.by $1,$1,$15,$1,$51,$4,$41,$45,$50,$10,$00,$15,$50,$15,$1,$50,$55,$41,$1,$10,$44,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.by $FF,$CC,$3F,$FF,$FF,$FF,$00,$3F,$FF,$FF,$FF,$F,$FF,$FF,$FF,$F0,$FF,$FF,$FF,$FF,$F,$FF,$FF,$FF,$F0,$3F,$FF,$FF,$FF,$CF,$FF,$FF,$FF,$F0,$FF,$FF,$FF,$FF,$00,$FC
	.by $FF,$FC,$3F,$FF,$FF,$FF,$00,$3F,$FF,$FF,$FF,$F,$FF,$FF,$FF,$F0,$FF,$FF,$F3,$FF,$F,$FF,$FC,$FF,$F0,$3F,$FF,$FF,$FF,$CF,$FF,$FF,$F3,$F0,$FF,$FF,$FF,$FF,$00,$FC
	.by $FF,$FC,$3F,$FF,$FF,$F0,$C0,$3F,$CF,$FF,$FF,$F,$FF,$CF,$FF,$F0,$FF,$FF,$FF,$FF,$F,$FF,$FF,$FF,$F0,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$F0,$FF,$F3,$FF,$FF,$3F,$FC
	.by $FF,$FC,$3F,$FF,$FC,$FC,$C0,$3F,$FF,$FF,$FF,$F,$FF,$FF,$FF,$F0,$FF,$3F,$FF,$3F,$F,$FF,$FF,$FF,$F0,$3F,$FF,$3F,$FF,$C3,$FF,$FF,$FF,$F0,$FF,$FF,$FF,$FF,$3F,$FC
	.by $FF,$FC,$3F,$FF,$FF,$FF,$00,$3F,$FF,$FF,$FF,$F,$FF,$FF,$FF,$F0,$FF,$FF,$FF,$FF,$F,$FF,$FF,$FF,$F0,$3F,$FF,$FF,$FF,$C3,$FF,$FF,$FF,$F0,$FF,$FF,$FF,$FF,$3F,$FC
	.by $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;---------------------------------------
; Zona de memoria para el Puzzle
;---------------------------------------
	org $4000
pant_intermedia
	ins "niveles/nivel0.map"
;	icl "niveles.asm"

;---------------------------------------
; Zona de Memoria para cambiar el FONT
; y se agrega el archivo fnt
;---------------------------------------
	org $A000
font
	ins "fuente.fnt"

    run inicio