extends Control

@onready var label = $Label
@onready var timer = $Timer

var siguienteEscena #variable para ir siguiente escena

#que comience el timer
func _ready() -> void:
	timer.start()


func time_left_to_live(): #esta funcion se encarga "setea" los valores del tiempo cuando la llamen
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60 
	return [minute, second]

func _process(_delta: float) -> void: #Aca modifica los datos del tiempo por fotograma, usando la funcion
	label.text = "Time: %02d:%02d" % time_left_to_live()
	
	
func _on_timer_timeout() -> void: #cambio de escena
	$"../TransitionControl".visible = true
	$"../TransitionControl/AnimationPlayer".play_backwards("screen_transition")
	await $"../TransitionControl/AnimationPlayer".animation_finished
	get_tree().change_scene_to_file(siguienteEscena)
	pass

func set_Siguiente_Escena(path):
	siguienteEscena = path
