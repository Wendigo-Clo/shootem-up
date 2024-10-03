extends CharacterBody2D

func _physics_process(delta: float) -> void:
	position.y += 15
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass 

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("nave"):
		queue_free()
	pass 
