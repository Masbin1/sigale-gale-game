extends Node2D

@export var bpm: float = 125.0
@export var song_offset: float = 1.2   # 🔥 mulai dari detik ke-1

var beat_interval: float

@onready var music: AudioStreamPlayer = $Music

func _ready():
	beat_interval = 60.0 / bpm

	music.play()
	music.seek(song_offset)   # ✅ ini yang benar

func _process(_delta):
	if Input.is_action_just_pressed("hit"):
		$Lane/HitZone.try_hit()

func get_song_time() -> float:
	return max(0.0, music.get_playback_position() - song_offset)
