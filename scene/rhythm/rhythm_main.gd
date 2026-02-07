extends Node2D

@onready var music: AudioStreamPlayer = $Music

@export var start_offset := 1.4   # detik mulai lagu

func _ready():
	print("Rhythm Scene Loaded ✅")

	music.play()
	music.seek(start_offset)

func _process(_delta):
	if Input.is_action_just_pressed("hit"):
		$Lane/HitZone.try_hit()

func get_song_time() -> float:
	return music.get_playback_position() - start_offset
