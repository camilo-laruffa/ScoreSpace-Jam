extends Node2D


onready var ENEMY = preload("res://Scenes/Enemy.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.

func _process(delta):
	$Control/Label.text = str(Global.points)
	if Global.combo % 10 == 0 : $Sound.play()
	if get_tree().get_nodes_in_group("Enemy").size() < 16 :
		var player_position = get_tree().get_nodes_in_group("Player")[0].position
		var enemy = ENEMY.instance()
		enemy.position.x = rng.randf_range(player_position.x - 300, player_position.x - 1000)
		if rng.randi_range(0,1) == 1 :
			enemy.position.x = rng.randf_range(player_position.x + 300, player_position.x + 1000)
		enemy.position.y = rng.randf_range(0, 768)
		get_parent().call_deferred("add_child", enemy)
	pass
