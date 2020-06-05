extends KinematicBody2D

var maxSpeed = 500
var acceleration = 2000
var motion = Vector2.ZERO
var bullet = preload("res://PlayerBullet.tscn")


func GetInputAxis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return axis.normalized()
	
func ApplyFriction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO;
	
func ApplyMotion(accel):
	motion += accel
	motion = motion.clamped(maxSpeed)
	
func Fire():
	var b = bullet.instance()
	get_tree().current_scene.add_child(b)
	b.set_global_position($Muzzle.global_position)
	b.set_global_rotation($Muzzle.global_rotation)
	b.speed += motion


func _input(event):
	if event.is_action_pressed("fire"):
		Fire()

func _physics_process(delta):
	var axis = GetInputAxis()
	
	if axis == Vector2.ZERO:
		ApplyFriction(acceleration * delta)
	else:
		ApplyMotion(axis * acceleration * delta)
	
	motion = move_and_slide(motion);
