extends CharacterBody2D
class_name Player

var facing_direction : int = 1
var direction : int = 0

var move_speed : float = 1200
var boost_speed : float = 1800

var ignore_gravity : bool = false
var max_gravity : float = 1800
var gravity : float = 3600

func _physics_process(delta):
	get_direction()
	apply_gravity(delta)
	control_camera(delta)
	move_and_slide()

func get_direction():
	if direction == 1:		facing_direction = 1
	elif direction == -1:	facing_direction = -1
func apply_gravity(delta):
	if not ignore_gravity:
		velocity.y = move_toward(velocity.y, max_gravity, delta * gravity)
func control_camera(delta):
	pass
