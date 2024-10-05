extends Node2D


func _ready() -> void:
		
	get_tree().paused = false
	$"Pausa-GameOver".visible = false
	add_child(preload("res://Scenes/vidas.tscn").instantiate())
	 #Pauso para presentacion
	await get_tree().create_timer(5).timeout

	add_child(preload("res://Scenes/spawn_pwr.tscn").instantiate())
	add_child(preload("res://Scenes/enemigoJefe.tscn").instantiate())

func _process(_delta: float) -> void:
		if Global.naveDestruida:             #Si la nave fue destruida, perdiste!
			MenuPerder()
		pass

func MenuPerder(): #abre pantalla de perder, reinicia el score y habilita el rejugar
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = true
	Global.rejugar = true
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
	Global.vidas = 3
	get_tree().reload_current_scene()
	pass # Replace with function body.

func _on_pausa_game_over_salir() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	pass # Replace with function body.
