extends CharacterBody2D

@export var velocidad: float = 200.0  # Velocidad de movimiento SACAR
@export_range(10,100) var speed := 20.0
var pre_laser_green = preload("res://Scenes/laserEnemigo3.tscn")
var direccion : Vector2
var estoyVivo = true

func _ready():
	$Timer.wait_time = randf_range(0.5, 0.7 ) #Que varie la velocidad de disparo segun la nav
	#(originalmente, la IZQ tenia distintoa a DER)

func set_direccion(dir: Vector2) -> void:
	direccion = dir

func _process(delta: float) -> void:
# Mueve al enemigo en la dirección asignada
	velocity = direccion * speed
	move_and_slide()
	

func Shoot(): #Que dispare
	if estoyVivo:
		var laser = pre_laser_green.instantiate()
		get_parent().add_child(laser)
		laser.position.x = position.x 
		laser.position.y = position.y + 80 
	pass
	
func _on_timer_timeout() -> void: #Cuando termine el tiempo haga:
	Shoot()
	pass 

func _on_visible_on_screen_notifier_2d_screen_exited() -> void: #destruir bala si sale de pantalla
	await get_tree().create_timer(0.5).timeout
	queue_free()
	pass 

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Laser"):
		Global.score += 400
		estoyVivo = false
		$AnimationPlayer.play("Explotion")
		$Area2D/CollisionPolygon2D.disabled
		$Explosion.play()
		await $AnimationPlayer.animation_finished
		queue_free()
		pass 
