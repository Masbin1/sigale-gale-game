extends Node2D

@onready var hit_line: Sprite2D = $HitLine

func flash():
	hit_line.modulate.a = 1.0
	await get_tree().create_timer(0.05).timeout
	hit_line.modulate.a = 0.5
