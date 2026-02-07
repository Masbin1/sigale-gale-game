extends Node2D

@export var note_scene: PackedScene
@export var spawn_x: float = 1400.0
@export var spawn_y: float = 140.0
@export var hit_x: float = 300.0
@export var travel_time: float = 2.0

@export var beats_per_note: int = 2  # 🔥 KUNCI: 2 beat = 1 note

@onready var notes: Node2D = $"../Notes"
@onready var rhythm = get_parent().get_parent()

var next_beat_time: float = 0.0

func _ready():
	next_beat_time = 0.0

func _process(_delta):
	var song_time = rhythm.get_song_time()

	if song_time >= next_beat_time:
		spawn_note()
		next_beat_time += rhythm.beat_interval * beats_per_note

func spawn_note():
	if note_scene == null:
		return

	var note = note_scene.instantiate()
	notes.add_child(note)

	note.position = Vector2(spawn_x, spawn_y)
	note.speed = (spawn_x - hit_x) / travel_time
