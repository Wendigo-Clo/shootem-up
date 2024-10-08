extends Node2D

@onready var MusicaNivel = $"MusicaNivel3" # Referencia al nodo de audio
var limiteSilecio = -10  # Volumen mínimo (silencio)
var velocidadFade = 2  # Qué tan rápido disminuye el volumen (ajustable)
var fading_out = false  # Control de si el fade out está activo
var batallaGanada = false

func _ready():
	$Fondo.set_velocidad(3) #Que el fondo sea el del nivel X, y a su velocidad.
	get_tree().paused = false
	#Transicion
	ComienzoTransicion()
	#presentacion de nivel
	PresentacionNivel()

	#Instancio la nave y los laterales
	add_child(preload("res://Scenes/laterales.tscn").instantiate())
	add_child(preload("res://Scenes/nave.tscn").instantiate())

	#Instancio las vidas y el score
	add_child(preload("res://Scenes/vidas.tscn").instantiate())
	add_child(preload("res://Scenes/score.tscn").instantiate())
	
	 #Pauso para presentacion
	await get_tree().create_timer(5).timeout

	#instancio el timer y le defino el cambio de escena
	var NodoTiempo = preload("res://Scenes/nodo_timer.tscn").instantiate()
	#aviso al timer que es el nivel 3
	NodoTiempo.nivel3 = true
	add_child(NodoTiempo)
	NodoTiempo.connect("terminoTiempo", Callable(self, "_on_time_finish"))

	#que no se vea el menu
	$"Pausa-GameOver".visible = false
		
	#Instancio spawns de powerup
	add_child(preload("res://Scenes/spawn_pwr.tscn").instantiate())

	#Instancio enemigos
	add_child(preload("res://Scenes/spawn_enemigo1.tscn").instantiate())
	add_child(preload("res://Scenes/spawn_enemigo2.tscn").instantiate())
	add_child(preload("res://Scenes/spawn_enemigo_3.tscn").instantiate())
	pass
	
	
func _process(delta: float) -> void:
	if Global.naveDestruida:             #Si la nave fue destruida, perdiste!
		MenuPerderGanar()
		
	if fading_out:
		fade_out(MusicaNivel, limiteSilecio, delta)
pass

func fade_out(musica3: AudioStreamPlayer2D, limiteBajo: float, delta: float): #bajo sonido para presentar al jefe
	if musica3.volume_db > limiteBajo: #bajar mas la musica
		musica3.volume_db -= velocidadFade * delta
	if musica3.volume_db <= limiteBajo: #suficientemente bajo
		musica3.volume_db = limiteBajo  
		fading_out = false  # Detener el fade out
		MusicaNivel.stop()
		EjecutarJefe()
pass



func MenuPerderGanar(): #abre pantalla de perder, reinicia el score y habilita el rejugar
	get_tree().paused = true
	$"Pausa-GameOver".visible = true
	if Global.naveDestruida:
		await get_tree().create_timer(0.1).timeout
		var sonidoMuerte = preload("res://Scenes/sonido_Muerte.tscn").instantiate()
		add_child(sonidoMuerte)
		$"Pausa-GameOver"/ColorRect/GameOver.visible = true
		$"Pausa-GameOver"/ColorRect/GameOver.text = "GAME OVER"
		$"Pausa-GameOver/ColorRect/VBoxContainer".visible = true
		$"Pausa-GameOver"/ColorRect/VBoxContainer/Jugar.visible = false
		$"Pausa-GameOver/ColorRect/VBoxContainer/ReJugar".visible = true
	else:
		await get_tree().create_timer(0.1).timeout
		add_child(preload("res://Scenes/sonido_victoria.tscn").instantiate())
		$"Pausa-GameOver"/ColorRect/GameOver.visible = true
		$"Pausa-GameOver"/ColorRect/GameOver.text = "YOU ROCK!"
		$"Pausa-GameOver/ColorRect/Points".text = "Points: " + str(Global.score)
		$"Pausa-GameOver/ColorRect/Points".visible = true
		$"Pausa-GameOver/ColorRect/VBoxContainer".visible = true
		$"Pausa-GameOver"/ColorRect/VBoxContainer/Jugar.text = "Continue"
		$"Pausa-GameOver"/ColorRect/VBoxContainer/Jugar.visible = true
		$"Pausa-GameOver/ColorRect/VBoxContainer/ReJugar".visible = false
	$"Pausa-GameOver/ColorRect/VBoxContainer/Salir".visible = true
pass


func PresentacionNivel():
	$"Pausa-GameOver".visible = true
	$"Pausa-GameOver"/ColorRect/GameOver.text = "LEVEL 3"
	$"Pausa-GameOver"/ColorRect/GameOver.visible = true
	$"Pausa-GameOver"/ColorRect/VBoxContainer.visible = false

func ComienzoTransicion():
	add_child(preload("res://Scenes/transition_control.tscn").instantiate())
	$TransitionControl/AnimationPlayer.play("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	$"TransitionControl".queue_free()
pass

func _on_time_finish(): #Cuando termine el primer tiempo:
	$"SpawnEnemigo1".queue_free()
	$"SpawnEnemigo2".queue_free()
	$"SpawnEnemigo3".queue_free()
	$"NodoTimer".queue_free()
	await get_tree().create_timer(2).timeout
	fading_out=true
pass

func EjecutarJefe():
	var jefe = preload("res://Scenes/enemigoJefe.tscn").instantiate()
	add_child(jefe)
	await get_tree().create_timer(2).timeout
	if Global.maxDificultadJefe:
		add_child(preload("res://Scenes/spawn_enemigo2.tscn").instantiate()) 
	add_child(preload("res://Scenes/spawn_enemigo_3.tscn").instantiate())
	jefe.connect("Vencido", Callable(self, "_ballataTerminada"))
pass

func _ballataTerminada():
	$"SpawnEnemigo3".queue_free()
	if Global.maxDificultadJefe:
		$"SpawnEnemigo2".queue_free()
	await get_tree().create_timer(0.5).timeout
	MenuPerderGanar()
	batallaGanada = true
	Global.score += 5000

func _on_pausa_game_over_jugar() -> void: #funcion jugar de boton
	if not batallaGanada:
		get_tree().paused = false
		$"Pausa-GameOver".visible = false
	else:
		add_child(preload("res://Scenes/transition_control.tscn").instantiate())
		$"TransitionControl/AnimationPlayer".play_backwards("screen_transition")
		await $"TransitionControl/AnimationPlayer".animation_finished
		get_tree().change_scene_to_file("res://Scenes/credito.tscn")
pass # Replace with function body.


func _on_pausa_game_over_rejugar() -> void: #funcion re jugar
	Global.reset()
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
