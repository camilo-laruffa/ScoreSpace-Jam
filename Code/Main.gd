extends Node2D


onready var ENEMY = preload("res://Scenes/Enemy.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.

func _process(delta):
	if get_tree().get_nodes_in_group("Enemy").size() < 16 :
		var enemy = ENEMY.instance()
		enemy.position.x = rng.randf_range(0, 1360)
		enemy.position.y = rng.randf_range(0, 768)
		get_parent().call_deferred("add_child", enemy)
	pass
