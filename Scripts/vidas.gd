extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.vidas == 3:
		$Vida3.show()
	if Global.vidas == 2:
		$Vida3.hide()
		$Vida2.show()
	if Global.vidas == 1:
		$Vida2.hide()
	if Global.vidas == 0:
		$Vida1.hide()

	pass
