extends CharacterBody2D

const SPEED = 500.0
var vidas = 1
var shot = true
var pre_laser = preload("res://Scenes/laser.tscn")


func _ready():
	#var center = Vector2(550,550)
	position.x = 550
	position.y = 550

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
	if Input.is_action_just_pressed("ui_accept") and shot:
		var Laser = pre_laser.instantiate()
		get_parent().add_child(Laser)
		Laser.position.x = position.x
		Laser.position.y = position.y - 50
		shot = false
		await get_tree().create_timer (0.1).timeout
		shot = true
		pass
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemigo"):
		Global.naveDestruida = true
		queue_free()
	pass # Replace with function body.
	
