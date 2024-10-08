extends CharacterBody2D

const SPEED = 500.0
var vidas = 1
var shot = true
var pre_laser = preload("res://Scenes/laser.tscn")
var pre_laser_2 = preload("res://Scenes/laser_2.tscn")
var current_laser = pre_laser  # Inicializa con el primer tipo de láser
var agarroPowerUp = false  # Define el tipo de power-up

func _ready():
	$AnimationPlayer.play("inicioEscena")


func _physics_process(_delta):
	move()
	Shoot()
pass

func move():
	var direction = Input.get_axis("ui_left","ui_right") #Toma las entradas por eje
	if direction: #Si la funcion se cumple (se apreta un boto, genera una xis)
		velocity.x = direction * SPEED # la velocidad (del character body) en x va a ser igual a el eje que apreto por la velocidad 
	else: #en cambio (si no se paretaron teclas) (no hay entradas
		velocity.x = 0 # (la velocidad en x es 0
	move_and_slide() #
pass

func Shoot():
	if Input.is_action_just_pressed("ui_accept") and shot and not Global.naveDestruida:
		var laser = current_laser.instantiate()
		get_parent().add_child(laser)
		laser.position.x = position.x -5
		laser.position.y = position.y -80
		shot = false
		await get_tree().create_timer (0.1).timeout
		shot = true
		pass
	pass

func _on_power_up_collected():
	if agarroPowerUp:
		current_laser = pre_laser_2  # Cambia al segundo tipo de láser


func _on_area_2d_area_entered(area):
	#Powerup Disparo
	if area.is_in_group("power_up"):  
		agarroPowerUp = true
		_on_power_up_collected() 
		area.queue_free()  # Elimina el power-up
	
	if area.is_in_group("powerUpLife"):
		if Global.vidas <=5:
			Global.vidas +=1
		area.queue_free() #Elimina el power-up de vida
	
	#Si entra enemigo al area
	if area.is_in_group("Enemigo") or area.is_in_group("BalaJefe"):
		if not Global.modoDios:
			Global.vidas -= 1
			$AnimationPlayer.play("perderVidas")
		pass
	#Cuando las vidas llegan a 0
	if Global.vidas == 0:
		$AnimationPlayer.play("Explosion")
		await get_tree().create_timer(1.2).timeout
		Global.naveDestruida = true  #Permite saber cuando se pierde, importante!
		queue_free()
	pass # Replace with function body.
	
