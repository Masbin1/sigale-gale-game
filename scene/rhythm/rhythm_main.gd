extends Node2D

# ======================
# 🎵 SONG CONFIG
# ======================
@export var bpm: float = 125.0
@export var song_offset: float = 1.2

@onready var music: AudioStreamPlayer = $Music

# ======================
# 🧠 HUD
# ======================
@onready var heart_container = $RhythmHUD/Heart

@onready var cd_three = $RhythmHUD/Countdown/count3
@onready var cd_two   = $RhythmHUD/Countdown/count2
@onready var cd_one   = $RhythmHUD/Countdown/count1
@onready var cd_timer = $RhythmHUD/CountdownTimer

@onready var start_button = $RhythmHUD/StartButton
@onready var pause_button = $RhythmHUD/PauseButton

# ======================
# 🧮 GAME STATE
# ======================
var beat_interval: float
var game_started := false
var game_over_state := false

var max_life := 4
var current_life := 4

var countdown_step := 0

# ======================
# 🚀 READY
# ======================
func _ready():
	beat_interval = 60.0 / bpm

	game_started = false
	game_over_state = false
	current_life = max_life

	update_hearts()
	hide_all_countdown()
	music.stop()

	# timer
	if not cd_timer.timeout.is_connected(_on_CountdownTimer_timeout):
		cd_timer.timeout.connect(_on_CountdownTimer_timeout)

	# buttons
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
	game_started = false
	game_over_state = false
	countdown_step = 0

	hide_all_countdown()
	show_countdown_step()

	cd_timer.start(1.0)

func show_countdown_step():
	hide_all_countdown()

	match countdown_step:
		0:
			cd_three.visible = true
		1:
			cd_two.visible = true
		2:
			cd_one.visible = true

func hide_all_countdown():
	cd_three.visible = false
	cd_two.visible = false
	cd_one.visible = false

func _on_CountdownTimer_timeout():
	countdown_step += 1

	if countdown_step >= 3:
		cd_timer.stop()
		hide_all_countdown()
		start_game()
	else:
		show_countdown_step()

# ======================
# 🎶 START GAME
# ======================
func start_game():
	print("🎵 GAME START")
	game_started = true
	game_over_state = false

	start_button.visible = false   # 👈 KUNCI UTAMA
	pause_button.visible = true    # optional

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
