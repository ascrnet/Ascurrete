; Archivo que contiene los Registros 
; del Hardware del ATARI XL-XE
;-------------------------------------

SDLSTL = $230
SDMCTL = $22f
GPRIOR = $26f
STRIG0 = $284
PCOLR0 = $2c0
PCOLR1 = $2c1
PCOLR2 = $2c2
PCOLR3 = $2c3
COLOR0 = $2c4
COLOR1 = $2c5
COLOR2 = $2c6
COLOR3 = $2c7
COLOR4 = $2c8
CHBAS  = $2f4
HPOSP0 = $d000
GRACTL = $d01d
CONSOL = $d01f
PMBASE = $d407
NMIEN  = $d40e



;---------------------------
; Zona de memoria para 
; manipular los PM
;---------------------------
PMDIR  = $7800
PLAYER_0 = PMDIR+1024 
PLAYER_1 = PMDIR+1280