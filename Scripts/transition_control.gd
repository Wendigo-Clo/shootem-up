extends Control
func fade_in():
	$AnimationPlayer.play("screen_transition")
	await $AnimationPlayer.animation_finished
func fade_out():
	$AnimationPlayer.play_backwards("screen_transition")
	await $AnimationPlayer.animation_finished
	
func change_scene(target: String) -> void:
	$AnimationPlayer.play("screen_transition")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene(target)
pass
