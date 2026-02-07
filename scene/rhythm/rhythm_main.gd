extends Node2D

func _ready():
	print("Rhythm Scene Loaded ✅")

func _process(_delta):
	if Input.is_action_just_pressed("hit"):
		$Lane/HitZone.try_hit()
