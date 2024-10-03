extends Marker2D

var pre_roca = preload("res://Scenes/Enemigo1.tscn")
var cae = true

func _physics_process(_delta):
	if cae:
			var roca = pre_roca.instantiate()
			get_parent().add_child(roca)
			roca.global_position = global_position
			cae = false
			await get_tree().create_timer(0.8).timeout #1.3
			cae = true
			pass
	pass
