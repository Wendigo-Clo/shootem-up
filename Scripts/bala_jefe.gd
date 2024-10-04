extends CharacterBody2D
var speed = 200
#var VelDirecc : Vector2 #Variable vacia que voy a personalizar cuando instancie


func _process(delta):
	position += velocity * speed * delta #Actualizo posicion * velocidad y direccion por ejecucion de frame

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	if area.is_in_group("Nave"):
		$Sprite2D.visible = false
		$Area2D/CollisionShape2D.queue_free()
		await get_tree().create_timer (0.1).timeout
		#Daño a la nave
		Global.naveDestruida = true
		queue_free()
	pass # Replace with function body.
