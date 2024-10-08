extends RigidBody2D
var velocity = Vector2(0, 140) #Velocidad vertical negativa

func _physics_process(delta):
	position += velocity * delta
	if position.y > 800:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("nave"):
		$Area2D/CollisionShape2D.queue_free()
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.2).timeout
		$Sprite2D.visible = false
		await get_tree().create_timer(3).timeout 
		queue_free()
	pass 
