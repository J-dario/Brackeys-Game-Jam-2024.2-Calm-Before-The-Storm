extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func reset():
	Global.erro = 0
	sprite_2d.region_rect.position.y = 0
	
func strike():
	audio_stream_player_2d.play()
	Global.error += 1
	print(self.get_path())
	sprite_2d.region_rect.position.y += 50
	if Global.error == 3:
		print("loser")
