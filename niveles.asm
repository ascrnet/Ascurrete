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
    dta '        1111        '
    dta '    1111    1111    '
    dta '   1111      1111   '
    dta '   1111      1111   '
    dta '   1111      1111   '
    dta '   1111      1111   '
    dta '   1111      1111   '
    dta '   1111      1111   '
    dta '   1111      1111   '
    dta '    1111    1111    '
    dta '        1111        '

nivel1
    .by 0,0,0,0
    dta '                    '
    dta '                    '
    dta '                    '
    dta '                    '
    dta '        11          '
    dta '1                  1'
    dta '1                  1'
    dta '        11          '
    dta '                    '
    dta '                    '
    dta '                    '

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
