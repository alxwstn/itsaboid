extends Node3D

@onready var flock = $Flock
@onready var cage = $Cage
@onready var ui = $UI

var boidParams = {
	"boids": [],
	"turnfactor": 0.75,
	"visualRange": 5,
	"protectedRange": 2,
	"centeringfactor": 0.0005,
	"avoidfactor": 0.05,
	"matchingfactor": 0.05,
	"maxspeed": 8,
	"minspeed": 3,
	"flockSize": 15
}
var xbounds = Vector2(-16, 16)
var ybounds = Vector2(0, 20)
var zbounds = Vector2(-12, 12)

# Called when the node enters the scene tree for the first time.
func _ready():
	cage.initialize(xbounds, ybounds, zbounds)
	flock.reset_boids(boidParams, xbounds, ybounds, zbounds)	
	ui.initialize(boidParams)

func _on_ui_state_reset(_boidParams):
	boidParams = _boidParams
	flock.reset_boids(boidParams, xbounds, ybounds, zbounds)
