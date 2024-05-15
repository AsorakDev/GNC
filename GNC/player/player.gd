extends CharacterBody2D
class_name Player

var facing_direction : int = 1
var direction : int = 0

var move_speed : float = 900
var boost_speed : float = 1200

var ignore_gravity : bool = false
var max_gravity : float = 1800
var gravity : float = 5600

@onready var collision_shape_2d = $JumpAttackArea/CollisionShape2D

func _physics_process(delta):
	get_direction()
	apply_gravity(delta)
	control_camera(delta)
	move_and_slide()

func get_direction():
	if is_on_floor():
		if direction == 1:		facing_direction = 1
		elif direction == -1:	facing_direction = -1
func apply_gravity(delta):
	if not ignore_gravity:
		velocity.y = move_toward(velocity.y, max_gravity, delta * gravity)
		
	if velocity.y < 0:
		gravity = 2400
		
	elif velocity.y > 0:
		collision_shape_2d.disabled = true
		gravity = 5600
		
func control_camera(_delta):
	pass
