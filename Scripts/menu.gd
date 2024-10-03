extends Control

func _ready() -> void:
	get_tree().paused = false
	$TransitionControl.visible = true
	$TransitionControl/AnimationPlayer.play("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	$TransitionControl.visible = false

func _on_play_pressed() -> void:
	$TransitionControl.visible = true
	$TransitionControl/AnimationPlayer.play_backwards("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Nivel1.tscn")
	$TransitionControl.visible = false
	pass 
	
func _on_quit_pressed() -> void:
	get_tree().quit()
	pass 
