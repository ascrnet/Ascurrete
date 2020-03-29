;A 	= 	VALOR	CMP #VALOR 	BEQ 
;A 	<> 	VALOR 	CMP #VALOR 	BNE 
;A 	>= 	VALOR 	CMP #VALOR 	BCS
;A 	> 	VALOR 	CMP #VALOR 	BEQ y luego BCS 
;A 	< 	VALOR 	CMP #VALOR 	BCC
;INCLUIMOS LIBRERIAS ANEXAS
	ICL 'BASE/SYS_EQUATES.M65'
    org $2000
DOS
	JMP ($0C)
@START
	JSR DOS
inicio
//***********************************************
// Vamos a poner una interrupción VBI aquí
//***********************************************
	ldy #<VBI
	ldx #>VBI
	lda #$07	; Diferida
	jsr SETVBV	;Setea

;COLOR FONDO
	MWA #$02 COLOR2
	MVA #$02 COLOR4
//***********************************************
// BORRO CURSOR
//***********************************************
	LDA #$00
	LDY #$02
	STA ($58),Y
;BUCLE
    jmp *
    
    

//***********************************************
// seteamos reset
//***********************************************
COMIENZO
	LDX # <@START
	LDY # >@START
	LDA #$03
	STX $02
	STY $03
	STA $09
	LDY #$FF
	STY $08
	INY   
	STY $0244
	JMP INICIO
//***********************************************
// funcionalidades
// teclas especiales
// START SELECT OPTION
//***********************************************
.proc VBI
	lda consol
	cmp #$06
	beq esstart
	cmp #$05
	beq esselect
	cmp #$03
	beq esoption
	jmp vbi
esstart
	jmp inicio
esoption
	jmp *
esselect
	jmp *
	jmp $e462
.endp
    run COMIENZO