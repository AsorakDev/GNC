extends State
class_name TriminMove

@onready var enemy = $"../.."
@onready var ray_cast_bottom_left = $"../../RayCastBottomLeft"
@onready var ray_cast_bottom_right = $"../../RayCastBottomRight"
@onready var ray_cast_left = $"../../RayCastLeft"
@onready var ray_cast_right = $"../../RayCastRight"



func stateEnter():
	pass

func stateUpdate(delta):
	move(delta)
	transition()

func stateExit():
	pass

func move(delta):
	enemy.velocity.x = move_toward(enemy.velocity.x, enemy.move_speed * enemy.dirX, delta * 1200)
	enemy.velocity.y = move_toward(enemy.velocity.y, 60 * enemy.dirY, delta * 120)
	
	if enemy.velocity.y == 60:	
		enemy.dirY = -1
	elif enemy.velocity.y == -60:
		enemy.dirY = 1
	
	if not ray_cast_bottom_left.is_colliding() or ray_cast_left.is_colliding():
		enemy.dirX = 1
	elif not ray_cast_bottom_right.is_colliding() or ray_cast_right.is_colliding():
		enemy.dirX = -1
	
func transition():
	pass
