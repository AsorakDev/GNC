extends CanvasLayer

@onready var player = $".."
@onready var fsm = $"../FSM"

func _process(_delta):
	$DebugLabel.text = "State: " + fsm.current_state.name + "\nVel-X: " + str(player.velocity.x) + "\nVel-Y: " + str(player.velocity.y)\
	+ "\nBuffered: " + str($"../FSM/Slide".buffered) + "\nCan-Jump: " + str($"../FSM/Slide".can_jump) + "\nFacing-DIR: " + str(player.facing_direction)
	
	if fsm.current_state.name == "Slide":
		$"../Sprite2D".modulate = Color.GOLD
	else: $"../Sprite2D".modulate = Color.BLACK
