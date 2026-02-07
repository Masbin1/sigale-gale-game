extends Area2D

@export var speed: float = 600.0
@onready var rhythm = get_tree().get_root().get_node("RhythmMain")

func _process(delta):
	if not rhythm.game_started:
		return

	position.x -= speed * delta

	# NOTE KELEWAT → MISS
	if position.x < -600:
		print("MISS ❌ (note lewat)")
		rhythm.lose_life()
		queue_free()
