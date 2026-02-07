extends Node2D

func check_win():
	for slot in $Slots.get_children():
		if not slot.is_filled:
			return
	print("PUZZLE CLEAR 🎉")
