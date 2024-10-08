extends ProgressBar
var pasoPresentacion = false

func _ready() -> void:
	await get_tree().create_timer(4.2).timeout
	pasoPresentacion= true

func _process(_delta: float) -> void:
	if pasoPresentacion:
		self.position = Vector2(-6,634)
