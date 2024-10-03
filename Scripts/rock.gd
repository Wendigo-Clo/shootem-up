extends RigidBody2D

func _ready():
	#$AnimationPlayer.play("Idle")
	pass
	
func _physics_process(_delta: float) -> void:
	gravity_scale = 0.1 
	rotation_degrees -= 2
pass

func _on_area_2d_area_entered(area):
	if area.is_in_group("Laser") or area.is_in_group("nave"):
		Global.score += 50
		mass = 0.1
		$AnimationPlayer.play("Explotion")
		await get_tree().create_timer(1).timeout
		$Area2D/CollisionShape2D.disabled = true
		queue_free()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.
