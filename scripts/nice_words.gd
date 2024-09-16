extends Node2D

var prompts = ["MY TEAM\n\n---------", "THESE DEVS\n\n---------", "AAAAAAAAA\nAAAAAA"]
var wrong = ["ARE THE WORST\nPEOPLE\nTO EVER\nPLAY THIS\nGAME", "ARE\n\nACTUAL\n\nANIMALS", "**** **\n\n******\n\n******* ****"]
var right = ["ARE\nPROBABLY\nJUST HAVING A\nBAD DAY", "ARE TRYING\n\nTHEIR BEST\n\nBALANCE IS\n\nHARD", "I'm calm :D"]
var leftIsTrue
var RNG = RandomNumberGenerator.new()
@onready var prompt: Label = $Prompt
@onready var option_1: Button = $Option1
@onready var option_2: Button = $Option2
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	audio_stream_player_2d.play()
	Global.covered = true
	var variation = RNG.randi_range(0, 2)
	prompt.text = prompts[variation]
	
	leftIsTrue = RNG.randi_range(0, 1)
	if leftIsTrue:
		option_1.text = right[variation]
		option_2.text = wrong[variation]
	else:
		option_2.text = right[variation]
		option_1.text = wrong[variation]

func _on_option_1_pressed() -> void:
	if !leftIsTrue:
		var strikes = get_node("/root/Node2D/Strikes")
		strikes.strike()
	Global.covered = false
	queue_free()

func _on_option_2_pressed() -> void:
	if leftIsTrue:
		var strikes = get_node("/root/Node2D/Strikes")
		strikes.strike()
	Global.covered = false
	queue_free()

func _on_timer_timeout() -> void:
	progress_bar.value -= 5
	if progress_bar.value == 0:
		var strikes = get_node("/root/Node2D/Strikes")
		strikes.strike()
		Global.covered = false
		queue_free()
