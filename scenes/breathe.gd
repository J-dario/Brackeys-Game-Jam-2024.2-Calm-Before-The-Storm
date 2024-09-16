extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var breath: Sprite2D = $Breath
@onready var instrructions: Label = $Instrructions
@onready var key_1: Sprite2D = $Key1
@onready var key_2: Sprite2D = $Key2
@onready var key_3: Sprite2D = $Key3
var possible = ["Q", "W", "E", "R", "Left", "Right"]
var solution = []
var keys = []
var RNG = RandomNumberGenerator.new()
var sol4
var sol5
var sol6
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	Global.covered = true
	audio_stream_player_2d.play()
	var sol1 = RNG.randi_range(0, 3)
	var sol2 = RNG.randi_range(0, 3)
	var sol3 = RNG.randi_range(0, 3)
	sol4 = RNG.randi_range(4, 5)
	sol5 = RNG.randi_range(4, 5)
	sol6 = RNG.randi_range(4, 5)

	solution.append(possible[sol1])
	solution.append(possible[sol2])
	solution.append(possible[sol3])
	solution.append(possible[sol4])
	solution.append(possible[sol5])
	solution.append(possible[sol6])
	
	key_1.region_rect.position.x = sol1*22
	key_2.region_rect.position.x = sol2*22
	key_3.region_rect.position.x = sol3*22
	
	keys.append(key_1)
	keys.append(key_2)
	keys.append(key_3)

func action(acc):
	if solution[0] == acc:
		solution.pop_front()
		for i in range(len(keys)):
			if keys[i].visible == true:
				keys[i].hide()
				break
	else:
		var strikes = get_node("/root/Node2D/Strikes")
		strikes.strike()
		Global.covered = false
		queue_free()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Q"):
		action("Q")
	elif Input.is_action_just_pressed("W"):
		action("W")
	elif Input.is_action_just_pressed("E"):
		action("E")
	elif Input.is_action_just_pressed("R"):
		action("R")
	elif Input.is_action_just_pressed("Left"):
		action("Left")
	elif Input.is_action_just_pressed("Right"):
		action("Right")
	
	if len(solution) == 3:
		breath.region_rect.position.x = 446
		key_1.region_rect.position.x = sol4*22
		key_2.region_rect.position.x = sol5*22
		key_3.region_rect.position.x = sol6*22
		instrructions.text = "Deep Breaths\n\nBreathe Out"
		key_1.show()
		key_2.show()
		key_3.show()
	
	if len(solution) == 0:
		Global.covered = false
		queue_free()

func _on_timer_timeout() -> void:
	progress_bar.value -= 5
	if progress_bar.value == 0:
		var strikes = get_node("/root/Node2D/Strikes")
		strikes.strike()
		Global.covered = false
		queue_free()
