extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $ProgressBar/Timer
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var progress_bar_2: ProgressBar = $ProgressBar2
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player_2d.play()
	Global.covered = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Space"):
		if sprite_2d_2.region_rect.position.x == 0:
			sprite_2d_2.region_rect.position.x = 203
		else:
			sprite_2d_2.region_rect.position.x =0
		progress_bar_2.value += 10
		if progress_bar_2.value == 100:
			Global.covered = false
			queue_free()

func _on_timer_timeout() -> void:
	progress_bar.value -= 10
	if progress_bar.value == 0:
		var strikes = get_node("/root/Node2D/Strikes")
		strikes.strike()
		Global.covered = false
		queue_free()
