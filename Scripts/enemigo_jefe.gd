extends CharacterBody2D

var speed = 5 #velocidad de las balas
var puedoDisparar = true #Para que pare y no en cadecia
var dispareRecien = false
var cantDisp : int = 4 #Cantidad de balas
var pre_bullet = preload("res://Scenes/bala_jefe.tscn")

var atacando = false

var vida_max = 100.0
var vida_actual = 100.0

var randomAttack
var Cooldown = 1.0  # Tiempo en segundos entre ataques
var TiempoUltimoAtaque = 0.0
var ultimoAtaque=-1  #esto metido dentro de while mientras sea igual al anteior
var posActual = self.position
var comienzoAtaque = false

signal Vencido

func _ready() -> void:
	$AnimationPlayer.play("Presentacion")
	await $AnimationPlayer.animation_finished
	$Presentacion.queue_free()
	$MusicaJefe.play()
	comienzoAtaque=true
	actualizar_barra_vida()
	pass

	
func _process(delta: float) -> void:
	if (vida_actual>0 and comienzoAtaque):
		TiempoUltimoAtaque += delta  # Acumular el tiempo transcurrido
		if TiempoUltimoAtaque >= Cooldown and not atacando and not Global.naveDestruida:
			randomAttack = randi_range(0, 2)
			while ultimoAtaque == randomAttack:
				randomAttack=randi_range(0,2)
			pass
			ultimoAtaque=randomAttack
			match randomAttack:
				0: 
					DisparoRayo() 
				1:
					MoverNave()
				2:
					Dispara()
			TiempoUltimoAtaque = 0.0  # Reiniciar el contador


func MoverNave():
	atacando=true
	#Hacerlo transparente y teletransportarlo
	$AnimationPlayer.play("Transparencia")
	await $AnimationPlayer.animation_finished
	$Sprite2D/Area2D/Danio.disabled = true
	if position == posActual:
		while position == posActual: #Para que no respita lugar
			position = puntoAzar(randi_range(0,2))
		pass
		posActual = position
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play_backwards("Transparencia")
	$Sprite2D/Area2D/Danio.disabled = false
	await get_tree().create_timer(1).timeout
	atacando = false
pass

func puntoAzar(num: int):
	match(num):
		0: return Vector2(200, self.position.y)# Del lado Izq 110
		1: return Vector2(550, self.position.y) #centro
		2: return Vector2(910, self.position.y)
	


func DisparoRayo():
	atacando=true
	add_child(preload("res://Scenes/laserJefe.tscn").instantiate())
	await get_tree().create_timer(4).timeout
	$LaserJefe.queue_free()
	atacando=false
	pass

func Dispara():
	atacando=true
	for i in cantDisp:
		#DisparaCentro()
		Disparo()
		await get_tree().create_timer(0.3).timeout
		pass
	atacando = false
	pass

func Disparo():
	for direction in [Vector2(1, 1), Vector2(0, 1), Vector2(-1, 1)]: # (1, 1)DERECHA , (0,1)Centro, (-1, 1)IZQ
		disparoIzquierdo(direction)
		disparoDerecho(direction)
		pass                                      # con la que saque del for (multiplicada por speed) YA NORMALIZADA

func disparoIzquierdo(direction):
	var projectile = pre_bullet.instantiate()  #Instancio
	get_parent().add_child(projectile)         #Creo nodo hijo
	projectile.position = $Sprite2D/Area2D/Izquierda.global_position  #que spawnee en esta posicion
	projectile.velocity = direction.normalized() * speed #esto me permite actualizar la diraccion del proyectil

func disparoDerecho(direction):
	var projectile = pre_bullet.instantiate()  #Instancio
	get_parent().add_child(projectile)         #Creo nodo hijo
	projectile.position = $Sprite2D/Area2D/Derecha.global_position  #que spawnee en esta posicion
	projectile.velocity = direction.normalized() * speed #esto me permite actualizar la diraccion del proyectil
	pass     # con la que saque del for (multiplicada por speed) YA NORMALIZADA

func actualizar_barra_vida():
		$paraHealthBar/HealthBar.value = (vida_actual / vida_max) * 100

	
func recibir_dano(cantidad):
	vida_actual -= cantidad
	if vida_actual < 0: #vida nunca menor qu ecero
		vida_actual = 0
	actualizar_barra_vida()

#Si entra el laser (queda conectar
func _on_area_2d_area_entered(area):
	if area.is_in_group("Laser"):
		recibir_dano(1)
		$Impacto.play()
		$AnimationPlayer2.play("reciboDanio")
		area.visible = false
		if (vida_actual<=0):
			ExplosionesMuerte()
	pass # Replace with function body.


func ExplosionesMuerte():
	if atacando:
		await not atacando
	$AnimationPlayer2.play("Explosion")
	# Instanciar varias explosiones en diferentes posiciones
	for i in range(4): # Por ejemplo, 3 explosiones
		await get_tree().create_timer(0.6).timeout
		var explosion = preload("res://Scenes/explosion_jefe.tscn").instantiate()
		add_child(explosion)
		explosion.global_position = get_random_position()
	$AnimationPlayer.play("Transparencia")
	await $AnimationPlayer.animation_finished
	var explosion = preload("res://Scenes/explosion_jefe.tscn").instantiate()
	add_child(explosion)
	explosion.global_position = $Sprite2D/Area2D/FuenteLaser.global_position
	await get_tree().create_timer(2.2).timeout
	emit_signal("Vencido")
	queue_free()

func get_random_position() -> Vector2:
	return Vector2(randf_range(position.x -270, position.x + 270), randf_range(0, 20))
