extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 200
var velocity
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = move_and_slide(position.direction_to(get_tree().get_nodes_in_group("Player")[0].position) * speed)  	
	rotation = position.angle_to_point((get_tree().get_nodes_in_group("Player")[0].position)) + PI/2
	pass

func die():
	queue_free()
