extends Node3D

@onready var flock = $Flock
@onready var cage = $Cage

var boidParams = {
	"boids": [],
	"turnfactor": 0.5,
	"visualRange": 20,
	"protectedRange": 2,
	"centeringfactor": 0.0005,
	"avoidfactor": 0.05,
	"matchingfactor": 0.05,
	"maxspeed": 3,
	"minspeed": 2,
	"flockSize": 3
}
var xbounds = Vector2(-12, 12)
var ybounds = Vector2(0, 16)
var zbounds = Vector2(-12, 12)

# Called when the node enters the scene tree for the first time.
func _ready():
	cage.initialize(xbounds, ybounds, zbounds)
	flock.reset_boids(boidParams, xbounds, ybounds, zbounds)	

func _on_ui_state_reset(_boidParams):
	boidParams = _boidParams
	flock.reset_boids(boidParams, xbounds, ybounds, zbounds)