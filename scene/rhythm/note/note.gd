extends Area2D

@export var speed: float = 600.0

func _process(delta):
	position.x -= speed * delta

	# kalau sudah lewat kiri layar, hapus
	if position.x < -600:
		queue_free()
