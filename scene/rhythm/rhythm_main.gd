extends Node2D

# ======================
# 🎵 SONG CONFIG
# ======================
@export var bpm: float = 125.0
@export var song_offset: float = 1.2
@export var atlas_texture: Texture2D

@onready var music: AudioStreamPlayer = $Music

# ======================
# 🧠 HUD
# ======================
@onready var heart_container = $RhythmHUD/Heart
@onready var countdown_rect: TextureRect = $RhythmHUD/Countdown/TextureRect
@onready var countdown_timer: Timer = $RhythmHUD/CountdownTimer
@onready var start_button = $RhythmHUD/StartButton
@onready var pause_button = $RhythmHUD/PauseButton

# ======================
# 🧮 GAME STATE
# ======================
var beat_interval: float
var game_started: bool = false
var game_over_state: bool = false

var max_life: int = 4
var current_life: int = 4

# ======================
# 🔢 COUNTDOWN REGIONS
# ======================
var countdown_regions := [
	Rect2(4250, 3134, 496, 937),  # 3
	Rect2(4912, 3122, 672, 959),  # 2
	Rect2(5729, 3084, 538, 1035)  # 1
]

var countdown_index: int = 0


# ======================
# 🚀 READY
# ======================
func _ready():
	beat_interval = 60.0 / bpm

	game_started = false
	game_over_state = false
	current_life = max_life

	update_hearts()

	music.stop()
	countdown_rect.visible = false

	# timer
	if not countdown_timer.timeout.is_connected(_on_CountdownTimer_timeout):
		countdown_timer.timeout.connect(_on_CountdownTimer_timeout)

	# buttons (AMAN walau connect dari editor)
	if start_button and not start_button.pressed.is_connected(_on_start_button_pressed):
		start_button.pressed.connect(_on_start_button_pressed)

	if pause_button and not pause_button.pressed.is_connected(_on_pause_button_pressed):
		pause_button.pressed.connect(_on_pause_button_pressed)


# ======================
# 🎮 INPUT
# ======================
func _process(_delta):
	if not game_started:
		return

	if Input.is_action_just_pressed("hit"):
		$Lane/HitZone.try_hit()


# ======================
# ⏱ SONG TIME
# ======================
func get_song_time() -> float:
	if not game_started:
		return 0.0

	return max(0.0, music.get_playback_position() - song_offset)


# ======================
# ▶️ START BUTTON
# ======================
func _on_start_button_pressed():
	if game_started:
		return

	print("🔥 START BUTTON CLICKED")
	start_countdown()


# ======================
# ⏸ PAUSE BUTTON
# ======================
func _on_pause_button_pressed():
	if not game_started:
		return

	get_tree().paused = not get_tree().paused


# ======================
# 🔢 COUNTDOWN
# ======================
func start_countdown():
	countdown_index = 0
	game_started = false
	game_over_state = false

	show_countdown()
	countdown_timer.start(1.0)


func show_countdown():
	var atlas := AtlasTexture.new()
	atlas.atlas = atlas_texture
	atlas.region = countdown_regions[countdown_index]

	countdown_rect.texture = atlas
	countdown_rect.visible = true


func _on_CountdownTimer_timeout():
	countdown_index += 1

	if countdown_index >= countdown_regions.size():
		countdown_timer.stop()
		countdown_rect.visible = false
		start_game()
	else:
		show_countdown()


# ======================
# 🎶 START GAME
# ======================
func start_game():
	print("🎵 GAME START")
	game_started = true
	game_over_state = false

	music.play()
	music.seek(song_offset)


# ======================
# ❤️ LIFE SYSTEM
# ======================
func lose_life():
	if not game_started or game_over_state:
		return

	current_life -= 1
	current_life = clamp(current_life, 0, max_life)
	update_hearts()

	print("💔 LIFE:", current_life)

	if current_life <= 0:
		game_over()


func update_hearts():
	for i in range(max_life):
		heart_container.get_child(i).visible = i < current_life


# ======================
# ☠️ GAME OVER
# ======================
func game_over():
	if game_over_state:
		return

	game_over_state = true
	game_started = false

	print("☠️ GAME OVER")

	music.stop()

	# ⚠️ TIDAK reload scene otomatis
	# kalau mau restart manual:
	# get_tree().reload_current_scene()
