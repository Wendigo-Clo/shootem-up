extends Node2D



func _ready():
	$Fondo.set_velocidad(1) #Que el fondo sea el del nivel 1, a su velocidad.
	get_tree().paused = false
	#presentacion de nivel (hacer modulo)
	$"Pausa-GameOver".visible = true
	$"Pausa-GameOver"/ColorRect/GameOver.text = "NIVEL 1"
	$"Pausa-GameOver"/ColorRect/GameOver.visible = true
	$"Pausa-GameOver"/ColorRect/VBoxContainer.visible = false
	#Transicion (hacer modulo)
	add_child(preload("res://Scenes/transition_control.tscn").instantiate())
	$TransitionControl/AnimationPlayer.play("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	$"TransitionControl".queue_free()
	
	#Instancio la nave y los laterales
	add_child(preload("res://Scenes/nave.tscn").instantiate())
	add_child(preload("res://Scenes/laterales.tscn").instantiate())
	
	#Instancio las vidas
	add_child(preload("res://Scenes/vidas.tscn").instantiate())
	#Instancio el score
	add_child(preload("res://Scenes/score.tscn").instantiate())
	
	 #Pauso para presentacion
	await get_tree().create_timer(5).timeout
	#instancio el timer y le defino el cambio de escena
	var NodoTiempo = preload("res://Scenes/nodo_timer.tscn").instantiate()
	add_child(NodoTiempo)
	NodoTiempo.set_Siguiente_Escena("res://Scenes/Nivel2.tscn")

	#que no se vea el menu y instancio el score en 0
	$"Pausa-GameOver".visible = false
	Global.score = 0
	
	#Instancio spawns de powerup
	add_child(preload("res://Scenes/spawn_pwr.tscn").instantiate())
	
	#Instancio enemigo
	add_child(preload("res://Scenes/spawn_enemigo1.tscn").instantiate())
	pass
	

func _process(_delta: float) -> void:
		#$"Pausa-GameOver".visible = true 
		if Global.naveDestruida:             #Si la nave fue destruida, perdiste!
			MenuPerder()
		pass

func MenuPerder(): #abre pantalla de perder, reinicia el score y habilita el rejugar
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = true
	Global.rejugar = true
	Global.score = 0
	$"Pausa-GameOver".visible = true
	$"Pausa-GameOver"/ColorRect/GameOver.text = "GAME OVER"
	$"Pausa-GameOver"/ColorRect/GameOver.visible = true
	$"Pausa-GameOver/ColorRect/VBoxContainer".visible = true
	$"Pausa-GameOver/ColorRect/VBoxContainer/Salir".visible = true
	$"Pausa-GameOver"/ColorRect/VBoxContainer/Jugar.visible = false
	$"Pausa-GameOver/ColorRect/VBoxContainer/ReJugar".visible = true
pass


func _on_pausa_game_over_jugar() -> void: #funcion jugar de boton
	get_tree().paused = false
	$"Pausa-GameOver".visible = false
	$"Pausa-GameOver"/ColorRect/GameOver.text = "PAUSA!"
	pass # Replace with function body.


func _on_pausa_game_over_rejugar() -> void: #funcion re jugar
	Global.naveDestruida = false
	Global.rejugar = false
	Global.score = 0
	Global.vidas = 3
	get_tree().reload_current_scene()
	#Global.rejugar = false   #Si dejo esta linea, va a volver a abrir el menu al comienzo.
	pass # Replace with function body.

func _on_pausa_game_over_salir() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	pass # Replace with function body.
