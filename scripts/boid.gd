extends CharacterBody3D

class_name Boid
const SPEED = 5.0
var state

func initialize(_state, _position):
	state = _state
	position = _position
#
func _physics_process(delta):
	var direction = (Vector3(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0), 0)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	move_and_slide()
