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

		# ❌ NOTE KELUAR TANPA DI HIT = MISS
		if notes_in_zone.has(area):
			notes_in_zone.erase(area)

func try_hit():
	if notes_in_zone.is_empty():
		print("MISS ❌ (NO NOTE)")
		_miss()
		return

	var note = notes_in_zone[0]
	notes_in_zone.erase(note)
	note.queue_free()
	print("PERFECT ✅")

func _miss():
	var rhythm = get_parent().get_parent()
	if rhythm.has_method("lose_life"):
		rhythm.lose_life()
