extends Area2D

@export var accept_id := ""
var is_filled := false

func accept_piece(piece):
	if is_filled:
		return false

	if piece.piece_id == accept_id:
		piece.global_position = global_position
		piece.set_process_input(false)
		is_filled = true
		get_parent().get_parent().check_win()
		return true

	return false
