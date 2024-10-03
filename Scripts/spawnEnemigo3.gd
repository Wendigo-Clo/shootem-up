extends Node2D

var pre_ship = preload("res://Scenes/Enemigo3.tscn")
var TiempoSpawn = Timer.new()

func _ready() -> void:
	TiempoSpawn.timeout.connect(self._on_timer_timeout)
	TiempoSpawn.wait_time = 3
	
	TiempoSpawn.autostart=true
	add_child(TiempoSpawn)
	
func _on_timer_timeout():
	var ship_izq = pre_ship.instantiate()
	get_parent().add_child(ship_izq)
	ship_izq.position = $PosicionIzquierda.global_position
	ship_izq.set_direccion(Vector2.RIGHT * 20)  # Moverse hacia la derecha
	await get_tree().create_timer(1).timeout
	#inicio segunda nave por derecha
	var ship_der = pre_ship.instantiate()
	get_parent().add_child(ship_der)
	ship_der.position = $PosicionDerecha.global_position
	ship_der.set_direccion(Vector2.LEFT * 15)  # Moverse hacia la izquierda * 15 ( 200 codigo original)
	
