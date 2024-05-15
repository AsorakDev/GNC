extends CharacterBody2D
class_name Trimin

@onready var hurt_duration = $HurtDuration
var move_speed : float = 120
var dirX : int = 1
var dirY : int = 1
var hurt : bool = false

func _physics_process(delta):
	move_and_slide()
	
func X():
	if hurt and hurt_duration.is_stopped():
		hurt_duration.start()

func _on_hurt_area_area_entered(area):
	hurt = true
	print("DAMN")

func _on_hurt_area_area_exited(area):
	hurt = false

func _on_hurt_duration_timeout():
	print("DAMN")
