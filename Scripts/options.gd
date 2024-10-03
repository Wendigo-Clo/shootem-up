extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	$TransitionControl.visible = true
	$TransitionControl/AnimationPlayer.play("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	$TransitionControl.visible = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$Click.play()
	$TransitionControl.visible = true
	$TransitionControl/AnimationPlayer.play_backwards("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	pass # Replace with function body.



func _on_button_mouse_entered() -> void:
	$Hover.play()
	pass # Replace with function body.
