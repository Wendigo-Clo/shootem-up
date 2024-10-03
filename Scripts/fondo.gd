extends ParallaxBackground

var velocidad = 0

#Esta funcion setea el nivel que deben usar los parallaxLayer
func set_velocidad(nivel): 
	for child in get_children(): #ese for va a pasar por cada hijo
		if child is ParallaxLayer: #Si es un ParallaxLayer
			child.velocidad = nivel # la va a pasar el numero de nivel 
			child.set_velocidad(nivel) # esta funcion se llama desde Nivel(1,2 o 3)
pass
