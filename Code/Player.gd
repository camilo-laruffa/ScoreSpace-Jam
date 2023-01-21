extends KinematicBody2D
#onready var BULLET = preload("res://Assets/Scenes/Prefabs/Bullet.tscn")
#onready var BONUS = preload("res://Assets/Scenes/Prefabs/Bonus.tscn")
export(float) var SPEED: float = 400
onready var BULLET = preload("res://Scenes/Bullet.tscn")
var audios = ["res://Assets/Audio/singlelaser.wav","res://Assets/Audio/singlelaser2.wav","res://Assets/Audio/singlelaser3.wav"]
var POWER = 1
var BOMBS = 2
var LIVES = 3
var SCORE = 0
var speed 
var velocity = Vector2()
const CD = 0.1
var can_Shoot = true
var Visible = false
var time = 0
var is_shooting = false
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	pass 

func _physics_process(delta):	
	time += delta
	$LaserCast/Sprite.visible = false
	$Charge_Beam.visible = false
	$Charge_Beam.rotation += time
	$LaserCast.scale.x += sin(time * 10)
	rotation = get_global_mouse_position().angle_to_point(position) - PI/2
	_manage_input(delta)
	velocity = move_and_slide(velocity)
	if Input.is_action_pressed("dash"): velocity = move_and_slide(-get_global_mouse_position().direction_to(position) * SPEED*10)
	pass

func _manage_input(delta):
	velocity = Vector2()
	speed = SPEED
		
	if Input.is_action_just_pressed("shoot") && $ChargeTimer.is_stopped(): 
		_pium()
	if Input.is_action_pressed("shoot"): 
		if !$ChargeTimer.is_stopped():
			$Charge_Beam.visible = true
			$Charge_Beam.scale.x += sin(time * 10) * delta * 30
			$Charge_Beam.scale.y += sin(time * 10) * delta * 30
		if $ChargeTimer.is_stopped() && !is_shooting : 
			$ChargeTimer.start()
		speed = speed / 2
		if !$LaserTimer.is_stopped():
			if !$LaserSound.playing : 
				$LaserSound.play()
			_shoot()
		
	if Input.is_action_just_released("shoot"):
		$Charge_Beam.visible = false
		$Charge_Beam.scale.x = 1
		$Charge_Beam.scale.y = 1
		$ChargeTimer.stop()
		$LaserTimer.stop()
		$LaserSound.stop()
	#Movimiento	CANNOT GO OUT OF BOUNDS
	if Input.is_action_pressed("left") && position.x > 10: velocity.x -= 1
	if Input.is_action_pressed("right") && position.x < 1360: velocity.x += 1
	if Input.is_action_pressed("up") && position.y > 10: velocity.y -= 1
	if Input.is_action_pressed("down") && position.y < 700: velocity.y += 1
	
	velocity = velocity.normalized() * speed
	
func _pium():
	var bullet = BULLET.instance()
	bullet.init(-get_global_mouse_position().direction_to(position))
	bullet.position = position
	get_parent().call_deferred("add_child", bullet)
	$Pium.stream = load(audios[rng.randi_range(0,2)])
	$Pium.play()
	
func _shoot():
	$ChargeTimer.stop()
	$LaserCast/Sprite.visible = true
	$Charge_Beam.visible = false
	$Charge_Beam.scale.x = 1
	$Charge_Beam.scale.y = 1
	if $LaserCast.is_colliding():
		var collided_body = $LaserCast.get_collider()
		if collided_body.is_in_group("Enemy"):
			collided_body.get_parent().die()

func _on_LaserTimer_timeout():
	is_shooting = false
	$LaserSound.stop()
	

func _on_ChargeTimer_timeout():
	if $LaserTimer.is_stopped():
		$LaserTimer.start()
