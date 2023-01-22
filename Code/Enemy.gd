extends KinematicBody2D


onready var BLOOD = preload("res://Scenes/Blood.tscn")
onready var ARMA = preload("res://Scenes/Arma.tscn")
var speed = 200
var velocity

func _process(delta):
	velocity = move_and_slide(position.direction_to(get_tree().get_nodes_in_group("Player")[0].position) * speed)  	
	rotation = position.angle_to_point((get_tree().get_nodes_in_group("Player")[0].position)) + PI/2
	
	pass

func die():
	var arma = ARMA.instance()
	arma.shoot = false
	arma.position = position
	arma.scale = Vector2(1.5,1.5)
	arma.is_dropped = true
	get_parent().call_deferred("add_child", arma)
	var blood = BLOOD.instance()
	blood.position = position	
	get_parent().call_deferred("add_child", blood)
	Global.combo += 1
	Global.points += 1 * Global.combo
	queue_free()
