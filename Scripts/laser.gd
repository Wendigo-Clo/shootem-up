extends CharacterBody2D
var sonidoTermino = false

func _physics_process(_delta):
	position.y -= 10
pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemigo"):
		$Sprite2D.visible = false
		$Area2D/CollisionShape2D.queue_free()
		await get_tree().create_timer (0.1).timeout
		#if(sonidoTermino):
		#	queue_free()
	pass # Replace with function body.

'''
func _on_audio_stream_player_2d_finished():
	sonidoTermino = true
	pass # Replace with function body.
'''
