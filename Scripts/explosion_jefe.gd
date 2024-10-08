extends Node2D

func _ready():
	$AnimationPlayer.play("explosion")
	await $Explosion.finished
	queue_free()
