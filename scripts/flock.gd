extends Node

# scenes/boid.tscn
@export var boid_scene: PackedScene

func get_initial_boid_pos(xbounds: Vector2, ybounds: Vector2, zbounds: Vector2):
	return Vector3(
		randf_range(xbounds[0], xbounds[1]),
		randf_range(ybounds[0], ybounds[1]),
		8) 
		# For 3D, Also need to adjust camera
		#randf_range(zbounds[0], zbounds[1])) 

func reset_boids(state, xbounds: Vector2, ybounds: Vector2, zbounds: Vector2):
	
	for child in get_children():
		child.queue_free()
	
	for i in range(state["flockSize"]):
		var boid = boid_scene.instantiate()
		state["boids"].append(boid)
		boid.initialize(state, get_initial_boid_pos(xbounds, ybounds, zbounds))
		add_child(boid)
