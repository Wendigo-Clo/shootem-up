extends Node2D

var pre_ship = preload("res://Scenes/Enemigo3.tscn")
var TiempoIzq = Timer.new()
var TiempoDer = Timer.new()

func _ready() -> void:
	TiempoDer.timeout.connect(self._on_timer_der_timeout)
	TiempoIzq.timeout.connect(self._on_timer_izq_timeout)
	
	#wait_time
	TiempoIzq.wait_time = 4
	TiempoDer.wait_time = 3
	#autostart
	TiempoDer.autostart = true
	TiempoIzq.autostart = true
	#add_child
	add_child(TiempoIzq)
	add_child(TiempoDer)
	pass
	
# Método para el timer de la izquierda
func _on_timer_izq_timeout() -> void:
	var ship_izq = pre_ship.instantiate()
	get_parent().add_child(ship_izq)
	ship_izq.position = $PosicionIzquierda.global_position
	ship_izq.set_direccion(Vector2.RIGHT * 20)  # Moverse hacia la derecha

# Método para el timer de la derecha
func _on_timer_der_timeout() -> void:
	var ship_der = pre_ship.instantiate()
	get_parent().add_child(ship_der)
	ship_der.position = $PosicionDerecha.global_position
	ship_der.set_direccion(Vector2.LEFT * 15)  # Moverse hacia la izquierda * 15 ( 200 codigo original)
