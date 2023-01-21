extends Node


var audio_player = AudioStreamPlayer.new()
var audios = ["res://Assets/Audio/OUCHMEDISPARARON.wav","res://Assets/Audio/singlelaser.wav",
				"res://Assets/Audio/singlelaser2.wav","res://Assets/Audio/singlelaser3.wav"]
var time = 0
var points = 0
var highscore = 0
var combo = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	var sfx = load(audios[0]) 
	sfx.set_loop_mode(0)
	audio_player.stream = sfx

func _set_audio(audio_index):
	audio_player.stream = load(audios[audio_index])

