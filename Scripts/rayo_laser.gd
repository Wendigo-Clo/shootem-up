extends Node2D


const maxrange = 800
@onready var collision = $Line2D/Area2D/CollisionShape2D
@onready var particulas = $Line2D/Area2D/GPUParticles2D

var based_width = 22
var widthy = based_width
var shoot = false




func _process(delta: float) -> void:
	
	#var mouse_position = get_local_mouse_position() #ubicacion del mouse
	#var max_cast_to = mouse_position.normalized() * maxrange  #normaliza la direccion de vector y la multiplica por la distancia
	#$RayCast2D.target_position = max_cast_to #punto final del rayo en relación con la posición del nodo de origen.
	$RayCast2D.target_position = Vector2.DOWN * maxrange
	
	if $RayCast2D.is_colliding(): #si el rayo collisiona
		$Reference.global_position = $RayCast2D.get_collision_point() #la referencia aparece en el punto de collision dle raycast
		$Line2D.set_point_position(1,$Line2D.to_local($Reference.global_position)) #setea la linea donde este la referencia
	else: #si no collisiona
		$Reference.global_position = $RayCast2D.target_position  #la referencia es igual al final del raycast (la constante definida)
		$Line2D.points[1] = $Reference.global_position #y la final del line tambien lo pone en la conste

	collision.shape.b = $Line2D.points[1] #punto b del collision, como el punto 1 del line

	collision.shape.b = $Line2D.points[1]
	collision.disabled = false
	$Line2D.visible = true
	
	
