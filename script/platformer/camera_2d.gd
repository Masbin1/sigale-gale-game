extends Camera2D

# ===== CONFIG =====
@export var map_left_limit: float = 0.0
@export var map_right_limit: float = 18000.0
@export var map_top_limit: float = 0.0
@export var map_bottom_limit: float = 400.0

@export var follow_speed := 8.0   # smoothing kamera

# ===== INTERNAL =====
var target_x: float


func _ready():
	enabled = true

	# Kamera start nempel kiri map
	limit_left = map_left_limit
	limit_right = map_right_limit
	limit_top = map_top_limit
	limit_bottom = map_bottom_limit

	position_smoothing_enabled = true
	position_smoothing_speed = follow_speed

	# Paksa kamera di kiri saat start
	global_position.x = map_left_limit
	target_x = global_position.x


func _process(delta):
	var player := get_parent() as Node2D
	if player == null:
		return

	# Kamera HANYA BOLEH GERAK KE KANAN
	if player.global_position.x > target_x:
		target_x = player.global_position.x

	global_position.x = target_x
