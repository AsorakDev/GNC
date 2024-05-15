extends State
class_name PlayerJump

@onready var player = $"../.."
@onready var slide_charge_timer = $"../../SlideChargeTimer"
@onready var collision_standing = $"../../CollisionStanding"
@onready var collision_sliding = $"../../CollisionSliding"
@onready var collision_shape_2d = $"../../JumpAttackArea/CollisionShape2D"

func stateEnter():
	jump()

func stateUpdate(_delta):
	transition()

func stateExit():
	pass

func jump():
	player.velocity.y = -1600
	collision_shape_2d.disabled = false
	
func transition():
	state_transition.emit(self, "Idle")
	collision_sliding.disabled = true
	collision_standing.disabled = false
