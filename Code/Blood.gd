extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var rand = rng.randf_range(1,3)
	$Sprite.scale = Vector2(rand,rand)
	$Sprite.rotation = rand

func _on_Timer_timeout():
	queue_free()
