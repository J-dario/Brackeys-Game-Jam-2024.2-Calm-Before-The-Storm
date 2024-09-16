extends Node2D

var possible = ["Q", "W", "E", "R", "Left", "Right"]
var solution
var RNG = RandomNumberGenerator.new()
@onready var minion: Sprite2D = $Minion
@onready var key: Sprite2D = $Key
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2

func _ready() -> void:
	# Sprite Variation
	var variation = RNG.randi_range(0, 1)
	minion.region_rect.position.x = 102*variation
	
	# Generate a solution
	var sol = RNG.randi_range(0, 5)
	solution = possible[sol]
	
	while solution in Global.minionSolutions:
		sol = RNG.randi_range(0, 5)
		solution = possible[sol]
		
	key.region_rect.position.x = sol*22
	Global.minionSolutions.append(solution)

func score():
	audio_stream_player_2d.play()
	Global.minionSolutions.erase(solution)
	Global.score += 5
	animation_player.play("score")
	
func smite():
	audio_stream_player_2d_2.play()
	audio_stream_player_2d.play()
	Global.minionSolutions.erase(solution)
	animation_player.play("smite")
