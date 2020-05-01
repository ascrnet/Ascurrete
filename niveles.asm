;---------------------------------------
; Diseño de niveles
;---------------------------------------

; Pantalla de prueba.....
;pant_puzzle
;:20 .by $40,$41
;:20 .by $42,$43
;:20 .by $40,$41
;:20 .by $42,$43
;:20 .by $40,$41
;:20 .by $42,$43
;:20 .by $40,$41
;:20 .by $42,$43
;:20 .by $40,$41
;:20 .by $42,$43
;:20 .by $40,$41
;:20 .by $42,$43
;:20 .by $40,$41
;:20 .by $42,$43
;:20 .by $40,$41
;:20 .by $42,$43
;:20 .by $40,$41
;:20 .by $42,$43
;:20 .by $40,$41
;:20 .by $42,$43
;:20 .by $40,$41
;:20 .by $42,$43


; Listado de niveles
niveles 
    .word nivel1,nivel1,nivel2,nivel3,nivel4
    .word nivel5,nivel6,nivel7,nivel8,nivel9
    .word nivel10,nivel11,nivel12,nivel13,nivel14
    .word nivel15

; Niveles - 20x11 caracteres
; x1,y1 - pelota
; x2,y2 - salida
nivel_temp
    .by 0,0,0,0
    dta '                    '
    dta '                    '
    dta '                    '
    dta '                    '
    dta '                    '
    dta '                    '
    dta '                    '
    dta '                    '
    dta '                    '
    dta '                    '
    dta '                    '

nivel0
    .by 0,0,0,0
;primero va la posicion y despues el tipo de dibujo
;segun numero 1 - 2 - 3 - 8 - 9 etc
;originalmente 214 valores versus 38
;
    dta 36,1
    dta 41,1,42,2,43,3,44,4,45,5,46,6,47,7,48,8,49,9	;21-40
    dta 65,2,85,3,105,3,125,3,145,4		;desde 61
    dta 150,5,151,6,152,6,153,6,154,7	;hasta 160
    dta 207,1,208,1,209,1,210,1			;desde 201
    dta 211,1,212,1,213,1,214,1			;hasta 220
;    dta '12345678901234567890';1-20
;    dta '               1    ';21-40   1 en 36
;    dta '                    ';41-60   ceros
;    dta '    2               ';61-80   2 en 65
;    dta '    3               ';81-100  3 en 85
;    dta '    3               ';101-120 3 en 105
;    dta '    3               ';121-140 3 en 125
;    dta '    4    56667      ';141-160 4 en 145 5 en 150 6 en 151 al 153 7 en 154
;    dta '                    ';161-180 ceros
;    dta '                    ';181-200 ceros
;    dta '      11111111      ';201-220 1 en 207 al 214
    
;nivel0
;    .by 0,0,0,0
;    dta '                    '
;    dta '               1    '
;    dta '                    '
;    dta '    2               '
;    dta '    3               '
;    dta '    3               '
;    dta '    3               '
;    dta '    4    56667      '
;    dta '                    '
;    dta '                    '
;    dta '      11111111      '

nivel1
    .by 6,0,0,0
    dta '                   A'
    dta '                    '
    dta '   B                '
    dta '   C        EFFFK   '
    dta '   C            C   '
    dta '   C            C   '
    dta '   C            C   '
    dta '   HFFFG        C   '
    dta '                D   '
    dta '                    '
    dta 'A               L   '

nivel2
    .by 0,0,0,0
    dta 'A                   '
    dta '                    '
    dta '                    '
    dta '   IFFFG      B     '
    dta '   C          C     '
    dta '   C          C     '
    dta '   C          C     '
    dta '   D      EFFFJ     '
    dta '                    '
    dta '                    '
    dta '                   A'

nivel3
    .by 0,0,0,0
    dta '                    '
    dta '               1    '
    dta '                    '
    dta '    2               '
    dta '    3               '
    dta '    3               '
    dta '    3               '
    dta '    4    56667      '
    dta '                    '
    dta '                    '
    dta '      11111111      '

nivel4
    .by 0,0,0,0
    dta '      111111        '
    dta '     1111111        '
    dta '    111 1111        '
    dta '   111  1111        '
    dta '  111   1111        '
    dta '        1111        '
    dta '        1111        '
    dta '        1111        '
    dta '        1111        '
    dta '11111111111111111111'
    dta '11111111111111111111'

nivel5
    .by 0,0,0,0
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '1       11         1'
    dta '1       11         1'
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '

nivel6
    .by 0,0,0,0
    dta '                    '
    dta '               1    '
    dta '                    '
    dta '    2               '
    dta '    3               '
    dta '    3               '
    dta '    3               '
    dta '    4    56667      '
    dta '                    '
    dta '                    '
    dta '      11111111      '

nivel7
    .by 0,0,0,0
    dta '      111111        '
    dta '     1111111        '
    dta '    111 1111        '
    dta '   111  1111        '
    dta '  111   1111        '
    dta '        1111        '
    dta '        1111        '
    dta '        1111        '
    dta '        1111        '
    dta '11111111111111111111'
    dta '11111111111111111111'

nivel8
    .by 0,0,0,0
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '1       11         1'
    dta '1       11         1'
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    
nivel9
    .by 0,0,0,0
    dta '                    '
    dta '               1    '
    dta '                    '
    dta '    2               '
    dta '    3               '
    dta '    3               '
    dta '    3               '
    dta '    4    56667      '
    dta '                    '
    dta '                    '
    dta '      11111111      '

nivel10
    .by 0,0,0,0
    dta '      111111        '
    dta '     1111111        '
    dta '    111 1111        '
    dta '   111  1111        '
    dta '  111   1111        '
    dta '        1111        '
    dta '        1111        '
    dta '        1111        '
    dta '        1111        '
    dta '11111111111111111111'
    dta '11111111111111111111'

nivel11
    .by 0,0,0,0
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '1       11         1'
    dta '1       11         1'
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '

nivel12
    .by 0,0,0,0
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '1       11         1'
    dta '1       11         1'
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '

nivel13
    .by 0,0,0,0
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '1       11         1'
    dta '1       11         1'
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '

nivel14
    .by 0,0,0,0
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '1       11         1'
    dta '1       11         1'
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '

nivel15
    .by 0,0,0,0
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '1       11         1'
    dta '1       11         1'
    dta '        11          '
    dta '        11          '
    dta '        11          '
    dta '        11          '