extends KinematicBody2D


var direction
var speed = 1500
var audios = ["res://Assets/Audio/singlelaser.wav","res://Assets/Audio/singlelaser2.wav","res://Assets/Audio/singlelaser3.wav"]
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var sfx = load(audios[rng.randi_range(0,2)])

func init(direction):
	self.direction = direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(direction * speed)

func _on_Area2D_area_entered(area):
	if area.is_in_group("Enemy") :		
		area.get_parent().die()
	queue_free()
	pass


func _on_Timer_timeout():
	Global.combo = 0
	queue_free()
