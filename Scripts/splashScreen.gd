extends Control

func _ready() -> void:
	$TransitionControl.visible = true
	$TransitionControl/AnimationPlayer.play("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	await get_tree().create_timer(2).timeout
	$TransitionControl/AnimationPlayer.play_backwards("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	$TransitionControl.visible = false
	pass
	
