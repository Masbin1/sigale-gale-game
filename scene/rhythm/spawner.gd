extends Node2D

@export var note_scene: PackedScene
@export var spawn_y: float = 150
@export var spawn_x: float = 400
@export var spawn_interval: float = 1.0

@onready var notes = $"../Lane/Notes"

func _ready():
	spawn_loop()

func spawn_loop():
	while true:
		spawn_note()
		await get_tree().create_timer(spawn_interval).timeout

func spawn_note():
	var note = note_scene.instantiate()
	note.position = Vector2(spawn_x, spawn_y)
	notes.add_child(note)
