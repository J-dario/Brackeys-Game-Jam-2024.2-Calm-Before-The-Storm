extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var hint: Label = $Hint
@onready var left: Label = $Left
@onready var up: Label = $Up
@onready var right: Label = $Right
@onready var key_1: Sprite2D = $Up/key1
@onready var key_2: Sprite2D = $Right/key2
@onready var key_3: Sprite2D = $Left/key3
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var RNG = RandomNumberGenerator.new()

var hints = ["--- -- --", "---- -- ----", "---- ---- -------", "- -- ----", "---- - ----"]
var leftW = ["It", "Easy", "Deep", "I", "Game"]
var upW = ["Let", "Take", "Breaths", "Calm", "Just"]
var rightW = ["Go", "It", "Take", "Am", "A"]
var possible = ["Q", "W", "E", "R", "Left", "Right"]
var solutions = [["Let", "It", "Go"], ["Take", "It", "Easy"], ["Take", "Deep", "Breaths"], ["I", "Am", "Calm"], ["Just", "A", "Game"]]
var sol
var sol1
var sol2
var sol3 
# added in the order of URL
var keyArray = []

func err():
	var strikes = get_node("/root/Node2D/Strikes")
	strikes.strike()
	Global.covered = false
	queue_free()

func action(acc):
	if acc not in keyArray:
		err()
	else:
		var pos = keyArray.find(acc)
		if pos == 0:
			if solutions[sol][0] == upW[sol]:
				solutions[sol].pop_front()
				key_1.hide()
			else:
				err()
		if pos == 1:
			if solutions[sol][0] == rightW[sol]:
				solutions[sol].pop_front()
				key_2.hide()
			else:
				err()
		if pos == 2:
			if solutions[sol][0] == leftW[sol]:
				solutions[sol].pop_front()
				key_3.hide()
			else:
				err()

func _ready() -> void:
	audio_stream_player_2d.play()
	Global.covered = true
	sol = RNG.randi_range(0, 4)
	
	hint.text = hints[sol]
	left.text = leftW[sol]
	up.text = upW[sol]
	right.text = rightW[sol]
	
	sol1 = RNG.randi_range(0, 5)
	key_1.region_rect.position.x = sol1*22
	keyArray.append(possible[sol1])
	
	sol2 = RNG.randi_range(0, 5)	
	while possible[sol2] in keyArray:
		sol2 = RNG.randi_range(0, 5)
	key_2.region_rect.position.x = sol2*22
	keyArray.append(possible[sol2])
	
	sol3 = RNG.randi_range(0, 5)
	while possible[sol3] in keyArray:
		sol3 = RNG.randi_range(0, 5)
	key_3.region_rect.position.x = sol3*22
	keyArray.append(possible[sol3])
	
	key_1.region_rect.position.x = sol1*22
	key_2.region_rect.position.x = sol2*22
	key_3.region_rect.position.x = sol3*22

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	
	if len(solutions[sol]) == 0:
		Global.covered = false
		queue_free()

func _on_timer_timeout() -> void:
	progress_bar.value -= 5
	if progress_bar.value == 0:
		var strikes = get_node("/root/Node2D/Strikes")
		strikes.strike()
		Global.covered = false
		queue_free()
