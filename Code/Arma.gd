extends Node2D

var texturas = ["res://Assets/Sprites/ak47.png","res://Assets/Sprites/shotgun.png",
					"res://Assets/Sprites/bomba.png","res://Assets/Sprites/bigbullet.png"]
var audios = ["res://Assets/Audio/singlelaser.wav","res://Assets/Audio/singlelaser2.wav",
					"res://Assets/Audio/singlelaser3.wav"]
onready var BULLET = preload("res://Scenes/Bullet.tscn")
var time = 0
export(bool) var shoot: bool = true
var rng = RandomNumberGenerator.new()
var player_bullet = false
var is_dropped = false

func _ready():
	rng.randomize()
	var texture = load(texturas[rng.randi_range(0,2)])
	$Sprite.texture = texture


func _process(delta):	
	time += delta
	rotation = sin(time * 5) / 4


func _on_Timer_timeout():
	$Timer.start()
	if shoot :
		_shoot()

func _shoot():
	$Pium.play()
	var bullet = BULLET.instance()
	var direction = global_position.direction_to(get_global_mouse_position())
	if !player_bullet : 
		direction = $ShootingPoint.global_position.direction_to(get_tree().get_nodes_in_group("Player")[0].global_position)
	bullet.init(direction)
	bullet.global_position = $ShootingPoint.global_position
	bullet.player_bullet = player_bullet
	bullet.get_node("Sprite").texture = load(texturas[3])
	bullet.get_node("Sprite").scale = -bullet.get_node("Sprite").scale 
	get_parent().get_parent().add_child(bullet)


func _on_ArmaCatch_area_entered(area):
	if area.name == "Player_Catchbox" && is_dropped :
		area.get_parent().load_weapon()
		queue_free()
	pass 
