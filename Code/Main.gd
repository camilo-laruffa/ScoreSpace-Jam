extends Node2D


onready var ENEMY = preload("res://Scenes/Enemy.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.

func _process(delta):
	$Control/ScoreLabel.text = str(Global.points)
	$Control/ComboLabel.text = str(Global.combo)
	if Global.combo % 2 == 0 && !$Sound.playing: $Sound.play()
	if get_tree().get_nodes_in_group("Enemy").size() < 40 :
		var player_position = get_tree().get_nodes_in_group("Player")[0].position
		var enemy = ENEMY.instance()
		enemy.position.x = rng.randf_range(player_position.x - 400, player_position.x - 1100)
		if rng.randi_range(0,1) == 1 :
			enemy.position.x = rng.randf_range(player_position.x + 400, player_position.x + 1100)
		enemy.position.y = rng.randf_range(0, 768)
		get_parent().call_deferred("add_child", enemy)
	var armas = get_tree().get_nodes_in_group("Arma")
	if armas.size() > 100 : 
		for arma in armas :
			if arma.is_dropped :
				arma.queue_free()
	pass
