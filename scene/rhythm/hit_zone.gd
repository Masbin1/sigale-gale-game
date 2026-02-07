extends Area2D

var notes_in_zone: Array = []

func _ready():
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
	

func _on_area_entered(area):
	if area.is_in_group("note"):
		print("NOTE MASUK HITZONE")
		notes_in_zone.append(area)

func _on_area_exited(area):
	if area.is_in_group("note"):
		print("NOTE KELUAR HITZONE")
		notes_in_zone.erase(area)


func try_hit():
	if notes_in_zone.is_empty():
		print("MISS ❌")
		return

	var note = notes_in_zone[0]
	note.queue_free()
	print("PERFECT ✅")
