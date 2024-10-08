extends Marker2D

var pre_roca = preload("res://Scenes/Enemigo1.tscn")
var cae = true
# Define los límites del área de spawn en el eje X
var spawn_area_min_x = 50
var spawn_area_max_x = 1100

func _physics_process(delta):
	if cae and not Global.menuPausa:
		var roca = pre_roca.instantiate()
		get_parent().add_child(roca)
		roca.global_position = Vector2(get_random_x_position(), global_position.y)
		cae = false
		await get_tree().create_timer(0.3).timeout
		cae = true
	pass
pass

# Función para obtener una posición aleatoria en el eje X
func get_random_x_position() -> float:
	return randf_range(spawn_area_min_x, spawn_area_max_x)
	
