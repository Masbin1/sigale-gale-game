extends CharacterBody2D
class_name Player

const SPEED = 450.0
const JUMP_VELOCITY = -1220.0
const MAX_JUMP = 2

# === FEEL CONTROL ===
const GRAVITY = 1800.0
const FALL_MULTIPLIER = 2.5
const LOW_JUMP_MULTIPLIER = 2.0

var jump_count := 0
var is_dead := false


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# ======================
	# GRAVITY (ANTI SLOW MO)
	# ======================
	if velocity.y < 0:
		velocity.y += GRAVITY * delta
	else:
		velocity.y += GRAVITY * FALL_MULTIPLIER * delta

	# ======================
	# FLOOR RESET
	# ======================
	if is_on_floor():
		jump_count = 0

	# ======================
	# JUMP (DOUBLE JUMP)
	# ======================
	if Input.is_action_just_pressed("ui_accept") and jump_count < MAX_JUMP:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	# ======================
	# VARIABLE JUMP HEIGHT
	# ======================
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= 0.5

	# ======================
	# HORIZONTAL MOVE
	# ======================
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED

	move_and_slide()


func die():
	if is_dead:
		return

	is_dead = true
	get_tree().reload_current_scene()
