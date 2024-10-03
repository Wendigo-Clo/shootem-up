extends Marker2D

var pre_pwr = preload("res://Scenes/power_up.tscn")
var pre_life = preload("res://Scenes/vida_power_up.tscn")
var cae = true
# Define los límites del área de spawn en el eje X
var spawn_area_min_x = 400
var spawn_area_max_x = 900

func _physics_process(_delta):
	await get_tree().create_timer(7).timeout
	if cae:
	#Instancio powerup de disparo
		var pwr = pre_pwr.instantiate()
		get_parent().add_child(pwr)
		pwr.global_position = Vector2(get_random_x_position(), global_position.y)
		
		#Instancio power up de vida
		var life = pre_life.instantiate()
		get_parent().add_child(life)
		life.global_position = Vector2(get_random_x_position(), global_position.y)
		cae = false

# Función para obtener una posición aleatoria en el eje X
func get_random_x_position() -> float:
	return randf_range(spawn_area_min_x, spawn_area_max_x)
	
