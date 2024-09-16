extends Node2D

const MINION = preload("res://scenes/minion.tscn")
var slot1 = null
var slot2 = null
var slot3 = null
var minions = []
@onready var marker_2d: Marker2D = $Marker2D
@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d_3: Marker2D = $Marker2D3
@onready var label: Label = $Label
@onready var strikes: Node2D = $Strikes
@onready var wave_timer: Timer = $ProgressBar/WaveTimer
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var timer: Timer = $Sprite2D/Timer
var RNG = RandomNumberGenerator.new()

const NICE_WORDS = preload("res://scenes/nice_words.tscn")
const FIST = preload("res://scenes/fist.tscn")
const BREATHE = preload("res://scenes/breathe.tscn")
const MANTRA = preload("res://scenes/mantra.tscn")

func minigame():	
	if Global.covered == false:		
		var game = RNG.randi_range(0, 3)
		if game == 0:	
			add_child(FIST.instantiate())
		elif game == 1:
			add_child(NICE_WORDS.instantiate())
		elif game == 2:
			add_child(MANTRA.instantiate())
		else:
			add_child(BREATHE.instantiate())
	
func spawnWave():
	Engine.time_scale += 0.05
	slot1 = MINION.instantiate()
	slot1.global_position = marker_2d_3.global_position
	add_child(slot1)
	minions.append(slot1)
	
	slot2 = MINION.instantiate()
	slot2.global_position = marker_2d_2.global_position
	add_child(slot2)
	minions.append(slot2)
	
	slot3 = MINION.instantiate()
	slot3.global_position = marker_2d.global_position
	add_child(slot3)
	minions.append(slot3)
	
	progress_bar.value = 100
	
func _process(delta: float) -> void:
	label.text = "Gold: " + str(Global.score)
	if Global.error == 3:
		get_tree().change_scene_to_file("res://scenes/lose.tscn")
	
	if Global.covered:
		wave_timer.paused = true
		return
	
	wave_timer.paused = false
	if progress_bar.value == 0:
		progress_bar.value = 100
		strikes.strike()
	
	if minions.is_empty():
		spawnWave()
	
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

func action(acc):
	if acc not in Global.minionSolutions:
		minigame()
		return
	
	if !minions.is_empty():
		for minion in minions:
			if minion.solution == acc:
				minions.pop_at(minions.find(minion))
				
				if RNG.randi_range(0, 10) == 7:
					animation_player.play("lee")
					minion.smite()
					timer.start()
				else:
					minion.score()
				
				break

func _on_wave_timer_timeout() -> void:
	progress_bar.value -= 2.5


func _on_timer_timeout() -> void:
	minigame() # Replace with function body.
