extends RigidBody2D
var cae = 3
var movimiento = Vector2()
var velocidad = 6

var player_position = Vector2.ZERO
#var nave_node = get_node("/root/Scenes/nave.tscn")


func _physics_process(_delta):
	gravity_scale = 0.1 
	rotation_degrees = 0
	
	move_and_collide(movimiento)
	if not Global.naveDestruida:
		set_vector(get_node("../Nave").global_position - global_position)
	else:
		movimiento = Vector2.ZERO
	

func set_vector(vector):
	movimiento = vector.normalized() * velocidad
pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Laser") or area.is_in_group("nave"):
		Global.score += 300
		$AnimationPlayer.play("Explosion")
		$Explosion.play()
		await get_tree().create_timer(1).timeout
		queue_free()
	pass 


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.
