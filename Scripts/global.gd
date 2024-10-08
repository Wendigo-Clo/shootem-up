extends Node

var rejugar : bool = false  #Para saber cuando rejugar y cuando es el menú de pausa

var naveDestruida : bool = false  #me permite saber cuando la nave fue destruida

var score = 0 

var vidas = 3

var menuPausa = false

var modoDios = false 

var maxDificultadJefe = false
#var escenaActual 

func reset(): #reseteo para volver a iniciar (menos modoDios
	rejugar = false  #Para saber cuando rejugar y cuando es el menú de pausa
	naveDestruida = false  #me permite saber cuando la nave fue destruida
	score = 0 
	vidas = 3
	menuPausa = false
	maxDificultadJefe = false
pass
