;---------------------------------------
; Diseño de niveles
;---------------------------------------

; Pantalla de prueba.....
pant_puzzle
:20 .by $40,$41
:20 .by $42,$43
:20 .by $40,$41
:20 .by $42,$43
:20 .by $40,$41
:20 .by $42,$43
:20 .by $40,$41
:20 .by $42,$43
:20 .by $40,$41
:20 .by $42,$43
:20 .by $40,$41
:20 .by $42,$43
:20 .by $40,$41
:20 .by $42,$43
:20 .by $40,$41
:20 .by $42,$43
:20 .by $40,$41
:20 .by $42,$43
:20 .by $40,$41
:20 .by $42,$43
:20 .by $40,$41
:20 .by $42,$43


; Listado de niveles
niveles 
    .word nivel0,nivel1,nivel2

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
    dta '      11111111      '
    dta '                    '
    dta '                    '
    dta '         2          '
    dta '         3          '
    dta '         3          '
    dta '         3          '
    dta '         4          '
    dta '                    '
    dta '                    '
    dta '      11111111      '

nivel1
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

nivel2
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
