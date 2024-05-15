extends CanvasLayer

@onready var player = $".."
@onready var fsm = $"../FSM"

func _process(delta):
	$DebugLabel.text = "State: " + fsm.current_state.name + "\nVel-X: " + str(player.velocity.x) + "\nVel-Y: " + str(player.velocity.y)
