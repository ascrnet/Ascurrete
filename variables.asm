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

; Variable de puntaje
puntaje .ds 7

; Variables temporales
temp1   .ds 2
temp2   .ds 2
temp3   .ds 2

; Variable de nivel del juego 
nivel   .ds 1

