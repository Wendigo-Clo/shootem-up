extends Node2D


func _ready():
	$Fondo.set_velocidad(1) #Que el fondo sea el del nivel 1, a su velocidad.
	get_tree().paused = false
	ComienzoTransicion()
	
	#presentacion de nivel
	PresentacionNivel()
	#Instancio la nave y los laterales 
	add_child(preload("res://Scenes/nave.tscn").instantiate())
	add_child(preload("res://Scenes/laterales.tscn").instantiate())
	
	#Instancio las vidas y el score
	add_child(preload("res://Scenes/vidas.tscn").instantiate())
	add_child(preload("res://Scenes/score.tscn").instantiate())
	
	 #Pauso para presentacion
	await get_tree().create_timer(7).timeout
	$"Pausa-GameOver/ColorRect/Points".visible = false
	#instancio el timer y le defino el cambio de escena
	var NodoTiempo = preload("res://Scenes/nodo_timer.tscn").instantiate()
	add_child(NodoTiempo)
	NodoTiempo.set_Siguiente_Escena("res://Scenes/Nivel2.tscn")

	#que no se vea el menu y instancio el score en 0
	$"Pausa-GameOver".visible = false # es tambien el que dice "nivel X"
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
	get_tree().paused = true
	await get_tree().create_timer(0.01).timeout
	add_child(preload("res://Scenes/sonido_Muerte.tscn").instantiate())
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

func ComienzoTransicion():
	add_child(preload("res://Scenes/transition_control.tscn").instantiate())
	$TransitionControl/AnimationPlayer.play("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	$"TransitionControl".queue_free()
	pass

func PresentacionNivel():
	await get_tree().create_timer(0.5).timeout
	$"Pausa-GameOver"/ColorRect/GameOver.text = "LEVEL 1"
	$"Pausa-GameOver/ColorRect/Points".text = "press ESC to pause || press SPACE to shoot"
	$"Pausa-GameOver".visible = true
	$"Pausa-GameOver/ColorRect/Points".visible = true
	$"Pausa-GameOver"/ColorRect/VBoxContainer.visible = false
pass


func _on_pausa_game_over_jugar() -> void: #funcion jugar de boton
	get_tree().paused = false
	$"Pausa-GameOver".visible = false
	pass # Replace with function body.


func _on_pausa_game_over_rejugar() -> void: #funcion re jugar
	Global.naveDestruida = false
	Global.rejugar = false
	Global.score = 0
	Global.vidas = 3
	get_tree().reload_current_scene()
	pass # Replace with function body.

func _on_pausa_game_over_salir() -> void:
	get_tree().paused=false
	if not Global.naveDestruida:
		$"Nave/Area2D/CollisionPolygon2D".disabled = true #Para que no cause problemas
	add_child(preload("res://Scenes/transition_control.tscn").instantiate())
	$"TransitionControl/AnimationPlayer".play_backwards("screen_transition")
	await $"TransitionControl/AnimationPlayer".animation_finished
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	pass # Replace with function body.
