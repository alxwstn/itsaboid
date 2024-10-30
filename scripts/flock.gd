extends Node

# scenes/boid.tscn
@export var boid_scene: PackedScene

var state = {
	"boids": [],
	"turnfactor": 0.2,
	"visualRange": 20,
	"protectedRange": 2,
	"centeringfactor": 0.0005,
	"avoidfactor": 0.05,
	"matchingfactor": 0.05,
	"maxspeed": 3,
	"minspeed": 2,
	"boidcount": 3
}

func get_initial_boid_pos():
	return Vector3(randf_range(0, 3),randf_range(0, 3),0)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(state["boidcount"]):
		var boid = boid_scene.instantiate()
		state["boids"].append(boid)
		boid.initialize(state, get_initial_boid_pos())
		add_child(boid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
