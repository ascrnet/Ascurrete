; Prodecimientos para borrar  
; todos los PMs 0,1,2,3
;--------------------------------
.proc limpia_pm
	ldx #$00
	ldy #$04 
limpiarpmg
	lda #$00
limpiar
	sta PMDIR,x
	inx
	bne limpiarpmg
	inc limpiar+2
	dey
	bne limpiarpmg
    rts
.endp
