extends Control

func _ready() -> void:
	get_tree().paused = false
	$TransitionControl.visible = true
	$TransitionControl/AnimationPlayer.play("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	$TransitionControl.visible = false

func _on_play_pressed() -> void:
	$Click.play()
	$TransitionControl.visible = true
	$TransitionControl/AnimationPlayer.play_backwards("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Nivel1.tscn")
	$TransitionControl.visible = false
	pass 
	
	
func _on_quit_pressed() -> void:
	$Click.play()
	$TransitionControl.visible = true
	$TransitionControl/AnimationPlayer.play_backwards("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	get_tree().quit()
	pass 

func _on_credits_pressed() -> void:
	$Click.play()
	$TransitionControl.visible = true
	$TransitionControl/AnimationPlayer.play_backwards("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/creditos.tscn")
	pass 


func _on_options_pressed() -> void:
	$Click.play()
	$TransitionControl.visible = true
	$TransitionControl/AnimationPlayer.play_backwards("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/options.tscn")
	pass # Replace with function body.
	


func _on_options_mouse_entered() -> void:
	$Hover.play()
	pass # Replace with function body.


func _on_play_mouse_entered() -> void:
	$Hover.play()
	pass # Replace with function body.


func _on_credits_mouse_entered() -> void:
	$Hover.play()
	pass # Replace with function body.


func _on_quit_mouse_entered() -> void:
	$Hover.play()
	pass # Replace with function body.
