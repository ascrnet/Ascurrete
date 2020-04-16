; Declaración de variables del juegos
; Página cero 
; $80 a $FF usadas por el BASIC 
;--------------------------------------

    org $80

; Dirección del movimiento  
; 0 = sin movimiento
; 1 = arriba
; 2 = abajo
; 3 = izquiera
; 4 = derecha
direccion .ds 1

; Posición X e Y de la pelota en pantalla
pelota_x  .ds 1
pelota_y  .ds 1

; Posición X de la pantalla
pant_x  .ds 2

