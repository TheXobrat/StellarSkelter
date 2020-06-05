extends KinematicBody2D

var speed = Vector2.UP * 1000


func _ready():
	 $Sprite.set_modulate(Color(0.75, 0.75, 1))

func _physics_process(delta):
	var collision = move_and_collide(speed * delta);
	#if collision != null:
		
