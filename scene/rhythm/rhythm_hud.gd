extends CanvasLayer
#
#@export var max_life: int = 3
#
#@onready var hearts = $Hearts
#@onready var pause_button = $PauseButton
#@onready var rhythm = get_parent()
#@onready var music: AudioStreamPlayer = $Music
#
#var current_life: int
#var paused := false
#
#func _ready():
	#current_life = max_life
	#update_hearts()
#
	## connect pause button
	#if pause_button is Button:
		#pause_button.pressed.connect(_on_pause_pressed)
	#elif pause_button.has_signal("pressed"):
		#pause_button.connect("pressed", _on_pause_pressed)
#
## =========================
## ❤️ HEART SYSTEM
## =========================
#func lose_life(amount: int = 1):
	#current_life -= amount
	#current_life = max(current_life, 0)
	#update_hearts()
#
	#if current_life <= 0:
		#game_over()
#
#func update_hearts():
	#for i in range(hearts.get_child_count()):
		#hearts.get_child(i).visible = i < current_life
#
#func game_over():
	#print("GAME OVER 💀")
	#get_tree().paused = true
	#music.stop()
#
## =========================
## ⏸ PAUSE SYSTEM
## =========================
#func _on_pause_pressed():
	#if paused:
		#resume_game()
	#else:
		#pause_game()
#
#func pause_game():
	#paused = true
	#get_tree().paused = true
	#music.stream_paused = true

#func resume_game():
	#paused = false
	#get_tree().paused = false
	#music.stream_paused = false
