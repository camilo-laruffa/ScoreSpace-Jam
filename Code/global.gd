extends Node


var time = 0
var points = 0
var highscore = 0
var combo = 0


# Called when the node enters the scene tree for the sfirst time.
func _ready():
	combo = 0
	pass

func _process(delta):
	if points > highscore : highscore = points


