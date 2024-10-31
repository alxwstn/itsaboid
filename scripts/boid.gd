extends CharacterBody3D

class_name Boid
const SPEED = 2.0
var state
@onready
var ray = $Ray

func initialize(_state, _position):
	state = _state
	position = _position
#
func _physics_process(delta):
	#var direction = (Vector3(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0), 0)).normalized()
	var direction = (Vector3(randf_range(.5, 1.0), randf_range(.5, 1.0), 0)).normalized()
	look_at(direction*100, Vector3.UP, true)
	
	if ray.is_colliding():
		var obj = ray.get_collider()
		if (obj.is_in_group("cage")):
			pass
			#print("I am still just a boid in a cage")
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
#
	move_and_slide()
