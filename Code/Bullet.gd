extends KinematicBody2D


var direction
var speed = 1500
var audios = ["res://Assets/Audio/singlelaser.wav","res://Assets/Audio/singlelaser2.wav","res://Assets/Audio/singlelaser3.wav"]
var rng = RandomNumberGenerator.new()
var player_bullet = false

# Called when the node enters the scene tree for the first time.
func _ready():	
	rng.randomize()
	var sfx = load(audios[rng.randi_range(0,2)])
	rotation = position.angle_to_point(get_global_mouse_position()) + PI/2
	if !player_bullet :
		rotation = position.angle_to_point((get_tree().get_nodes_in_group("Player")[0].position)) + PI/2
	

func init(direction):
	self.direction = direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(direction * speed)

func _on_Area2D_area_entered(area):
	if area.is_in_group("Enemy") && player_bullet:		
		area.get_parent().die()
	queue_free()
	pass


func _on_Timer_timeout():
	queue_free()
