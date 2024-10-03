extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#transicion
	$TransitionControl.visible = true
	$TransitionControl/AnimationPlayer.play("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	
	#creditos
	$AnimationPlayer.play("credits1")
	$Stars1/Stars.play("new_animation")
	$Stars2/Stars2.play("stars")
	
	#Cuando la animacion termine
	await get_tree().create_timer(25).timeout
	$TransitionControl/AnimationPlayer.play_backwards("screen_transition")
	await $TransitionControl/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	$TransitionControl.visible = false
	pass
