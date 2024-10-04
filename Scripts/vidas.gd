extends Node2D

'''
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Global.lives=3
	pass # Replace with function body.
	#Global.lives=3 ESTO ESTABA DE MÁS 
	update_lives_visual()
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.vidas == 2:
		$Vida3.hide()
	if Global.vidas == 1:
		$Vida2.hide()
	if Global.vidas == 0:
		$Vida1.hide()
	update_lives_visual() #no estoy seguro
	pass
	
# Función para incrementar vidas si son menores a 3
func increase_lives() -> void:
	if Global.vidas < 3:
		Global.vidas += 1
		

# Función para actualizar el estado visual de las vidas
func update_lives_visual() -> void:
	# Esconder todas las vidas inicialmente para que no queden visibles por error
	$Vida1.hide()
	$Vida2.hide()
	$Vida3.hide()
	
	# Mostrar las vidas según el número actual
	if Global.vidas >= 1:
		$Vida1.show()
	if Global.vidas >= 2:
		$Vida2.show()
	if Global.vidas >= 3:
		$Vida3.show()
	pass


'''# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.vidas == 3:
		$Vida3.show()
	if Global.vidas == 2:
		$Vida3.hide()
		$Vida2.show()
	if Global.vidas == 1:
		$Vida2.hide()
		$Vida3.hide()
	if Global.vidas == 0:
		$Vida1.hide()

	pass
