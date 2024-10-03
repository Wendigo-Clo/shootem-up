extends ParallaxLayer

var nivel = 0
var velocidad = 0

func _ready() -> void:
	set_velocidad(nivel)#comienza obteniendo que nivel es, y pone la velocidad que sea correcta

func set_velocidad(nivel_actual):
	match nivel_actual:
		1: velocidad = 120
		2: velocidad = 420 
		3: velocidad = 620

func _process(delta: float) -> void:
	self.motion_offset.y += velocidad * delta
	pass
