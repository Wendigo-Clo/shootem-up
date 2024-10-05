extends Node2D

const maxrange = 800

var based_width = 22
var widthy = based_width
var shoot = false


func _process(delta: float) -> void:
	$Line2D/Area2D/CPUParticles2D.visible = true
	$RayCast2D.target_position = Vector2.DOWN * maxrange #El final del raycast, es igual a vector abajo * maxrange
	
	if not $RayCast2D.is_colliding(): #si el rayo collisiona
		$Reference.global_position = $RayCast2D.target_position  #la referencia es igual al final del raycast (la constante definida)
		$Line2D.points[1] = $Reference.global_position #y la final del line tambien lo pone en la conste
	
	$Line2D/Area2D/CollisionShape2D.shape.b = $Line2D.points[1] #punto b del collision, como el punto 1 del line
	$Line2D/Area2D/CollisionShape2D.disabled = false
	$Line2D.visible = true
	pass
	
