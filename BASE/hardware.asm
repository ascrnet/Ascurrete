; Archivo que contiene los Registros 
; del Hardware del ATARI XL-XE
;-------------------------------------

RTCLOK = $14
ATRACT = $4d
SDLSTL = $230
SDMCTL = $22f
GPRIOR = $26f
STICK0 = $278
STRIG0 = $284
PCOLR0 = $2c0
PCOLR1 = $2c1
PCOLR2 = $2c2
PCOLR3 = $2c3
COLOR1 = $2c5
COLOR2 = $2c6
COLOR3 = $2c7
COLOR0 = $2c8
CHBAS  = $2f4
HPOSP0 = $d000
HPOSP1 = $d001
P0PF   = $d004
GRACTL = $d01d
HITCLR = $d01e  
CONSOL = $d01f
PMBASE = $d407
NMIEN  = $d40e
SETVBV = $e45C
XITVBV = $e462



;---------------------------
; Zona de memoria para 
; manipular los PM
;---------------------------
PMDIR  = $7800
PLAYER_0 = PMDIR+1024 
PLAYER_1 = PMDIR+1280