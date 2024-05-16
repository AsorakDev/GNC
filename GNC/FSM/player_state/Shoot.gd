extends State
class_name PlayerShoot

@onready var player = $"../.."
@onready var spawn_point = $"../../SpawnPoint"
@onready var PROJECTILE : PackedScene = preload("res://player/projectile.tscn")
@onready var projectile_manager = $"../../ProjectileManager"
@onready var shoot_charge_up_timer = $"../../ShootChargeUpTimer"
var projectile_inst

func stateEnter():
	player.ignore_gravity = true
	shoot_charge_up_timer.start()

func stateUpdate(delta):
	if projectile_manager.get_child_count() == 1:
		projectile_inst.spawn = spawn_point.global_position
	
	apply_friction(delta)
	transition()

func stateExit():
	player.ignore_gravity = false
	shoot_charge_up_timer.stop()

func apply_friction(delta):
	if player.is_on_floor():
		player.velocity.x = move_toward(player.velocity.x, 0, delta * 720)

func shoot():
	player.velocity = Vector2(-540, 0).rotated(spawn_point.rotation)
	player.ignore_gravity = false
	projectile_inst = PROJECTILE.instantiate()
	projectile_inst.global_position = spawn_point.global_position
	projectile_manager.add_child(projectile_inst)

func transition():
	if not Input.is_action_pressed("MM") and shoot_charge_up_timer.is_stopped() and projectile_manager.get_child_count() == 0:
		state_transition.emit(self, "Idle")
	
func _on_shoot_charge_up_timer_timeout():
	if Input.is_action_pressed("MM"):
		shoot()
