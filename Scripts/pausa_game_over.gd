extends Control


signal jugar
signal rejugar
signal salir

func _on_jugar_pressed():
	emit_signal ("jugar")
	pass

func _on_re_jugar_pressed() -> void:
	emit_signal("rejugar")
pass # Replace with function body.

func _on_salir_pressed():
	emit_signal("salir")
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		
		$ColorRect/GameOver.text = "PAUSE!"
		$ColorRect/GameOver.visible = true
		$ColorRect/VBoxContainer.visible=true
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused
		Global.menuPausa = get_tree().paused
pass
