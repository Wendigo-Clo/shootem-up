extends RigidBody2D

func _ready():
	#$AnimationPlayer.play("Idle")
	pass
	
func _physics_process(_delta: float) -> void:
	gravity_scale = 0.45
	rotation_degrees -= 2
pass

func _on_area_2d_area_entered(area):
	if area.is_in_group("Laser") or area.is_in_group("nave"):
		if area.is_in_group("Laser"):
			Global.score += 100
		mass = 0.1
		$Area2D/CollisionShape2D.queue_free()
		$AnimationPlayer.play("Explotion")
		$Explosion.play()
		await $Explosion.finished
		queue_free()
	pass # Replace with function body.

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	await get_tree().create_timer(2).timeout
	queue_free()
	pass # Replace with function body.
