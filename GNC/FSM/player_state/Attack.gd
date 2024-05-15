extends State
class_name PlayerAttack

@onready var player = $"../.."
@onready var collision_shape_2d = $"../../AttackArea/CollisionShape2D"
@onready var attack_duration_timer = $"../../AttackDurationTimer"

func stateEnter():
	if Input.is_action_pressed("LM"):	player.direction = -1
	elif Input.is_action_pressed("RM"):	player.direction = 1
	
	attack_duration_timer.start()
	collision_shape_2d.disabled = false
	if player.direction == -1:	collision_shape_2d.position.x = abs(collision_shape_2d.position.x) * -1
	elif player.direction == 1:	collision_shape_2d.position.x = abs(collision_shape_2d.position.x)

func stateUpdate(delta):
	attack(delta)
	transition()

func stateExit():
	collision_shape_2d.disabled = true
	
func attack(_delta):
	player.velocity.x = player.boost_speed * player.direction
	
func transition():
	if attack_duration_timer.is_stopped():
		state_transition.emit(self, "Idle")
	
	if Input.is_action_pressed("LM") and Input.is_action_pressed("RM"):
		state_transition.emit(self, "Slide")
