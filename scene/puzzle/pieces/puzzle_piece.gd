extends Area2D

@export var piece_id := ""
var dragging := false
var original_position : Vector2

func _ready():
	original_position = global_position

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		dragging = true

func _input(event):
	if dragging and event is InputEventMouseMotion:
		global_position = event.position

	if dragging and event is InputEventMouseButton and not event.pressed:
		dragging = false
		check_slot()

func check_slot():
	for area in get_overlapping_areas():
		if area.has_method("accept_piece"):
			if area.accept_piece(self):
				return

	global_position = original_position
