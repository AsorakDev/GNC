extends CharacterBody2D
class_name PlayerProjectile

var spawn : Vector2
var speed : float = 4800
var released : bool = false
var stop : bool = false

func _ready():
	look_at(get_global_mouse_position())

func _physics_process(delta):
	if not stop:
		speed = move_toward(speed, 3200, delta * 5400)
		velocity = Vector2(speed, 0).rotated(rotation)
	
	elif stop:
		velocity = Vector2.ZERO
	
	if released:
		stop = true
		look_at(spawn)
		global_position = global_position.move_toward(spawn, delta * 7200)
	
	if not Input.is_action_pressed("MM"):
		released = true
	
	if global_position == spawn and released:
		queue_free()
	
	move_and_slide()
	
func _on_hit_area_body_entered(body):
	if body as StaticBody2D:
		stop = true
