extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	position.y -= 10
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass 


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemigo") or area.is_in_group("Rock"):
		queue_free()
	pass # Replace with function body.
