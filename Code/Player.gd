extends KinematicBody2D
#onready var BULLET = preload("res://Assets/Scenes/Prefabs/Bullet.tscn")
#onready var BONUS = preload("res://Assets/Scenes/Prefabs/Bonus.tscn")
export(float) var SPEED: float = 400
var POWER = 1
var BOMBS = 2
var LIVES = 3
var SCORE = 0
var speed 
var velocity = Vector2()
const CD = 0.1
var can_Shoot = true
var Visible = false

func _ready():
	
	pass 

func _physics_process(delta):	
	$LaserCast/Sprite.visible = false
	rotation = get_global_mouse_position().angle_to_point(position) - PI/2
	_manage_input()
	velocity = move_and_slide(velocity)
	if Input.is_action_pressed("dash"): velocity = move_and_slide(-get_global_mouse_position().direction_to(position) * SPEED*10)
	pass

func _manage_input():
	velocity = Vector2()
	speed = SPEED
		
	if Input.is_action_pressed("shoot" ) && can_Shoot: 
		speed = speed / 2
		_shoot()
		if !$AudioStreamPlayer.playing : 
			$AudioStreamPlayer.play()
	if Input.is_action_just_released("shoot"):
		$AudioStreamPlayer.stop()
	#Movimiento	CANNOT GO OUT OF BOUNDS
	if Input.is_action_pressed("left") && position.x > 10: velocity.x -= 1
	if Input.is_action_pressed("right") && position.x < 1360: velocity.x += 1
	if Input.is_action_pressed("up") && position.y > 10: velocity.y -= 1
	if Input.is_action_pressed("down") && position.y < 700: velocity.y += 1
	
	velocity = velocity.normalized() * speed
	
func _shoot():
	$LaserCast/Sprite.visible = true
	if $LaserCast.is_colliding():
		var collided_body = $LaserCast.get_collider()
		if collided_body.is_in_group("Enemy"):
			$EnemyDeath.play()
			collided_body.die()
			
	
