extends Node2D

@onready var label_2: Label = $Label2
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	audio_stream_player_2d.play()
	label_2.text = "End Gold: " + str(Global.score)

func _on_button_pressed() -> void:
	Global.score = 0
	Global.error = 0
	Engine.time_scale = 1
	Global.minionSolutions = []
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
