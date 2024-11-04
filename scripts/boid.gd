extends StaticBody3D

class_name Boid

# "velocity" of our static body
var v = Vector3(0,0,0)

var boidParams
@onready
var ray = $Ray
const RAY_LENGTH = 2

#var boidParams = {
	#"boids": [],
	#"turnfactor": 0.2,
	#"visualRange": 20,
	#"protectedRange": 2,
	#"centeringfactor": 0.0005,
	#"avoidfactor": 0.05,
	#"matchingfactor": 0.05,
	#"maxspeed": 3,
	#"minspeed": 2,
	#"flockSize": 3
#}

# inintialize the boid with a reference to the flock parameters
func initialize(_boidParams, _position):
	boidParams = _boidParams
	position = _position
	$Ray.target_position = Vector3(0, 0, RAY_LENGTH)
#
func _physics_process(delta):
	# set up accumulators
	var pos_avg = Vector3(0,0,0)
	var vel_avg = Vector3(0,0,0)
	var close_delta = Vector3(0,0,0)
	var neighboring_boids = 0
	
	for boid in boidParams["boids"]:
		if boid == self:
			continue
		
		var difference = position - boid.position
		var distance = abs(difference.length())
		
		if distance < boidParams["visualRange"]:
			if distance < boidParams["protectedRange"]:
				close_delta += difference
			else:
				pos_avg += boid.position
				vel_avg += boid.v
				neighboring_boids += 1
		
	# add centering and matching velocity contributions from neighbors
	if neighboring_boids:
		pos_avg = pos_avg/neighboring_boids
		vel_avg = vel_avg/neighboring_boids
		v += ((pos_avg - position)*boidParams["centeringfactor"] + 
			 (vel_avg - v)*boidParams["matchingfactor"])

	# add the avoidance contribution to velocity
	# from neighbors in the protected range
	v += close_delta * boidParams["avoidfactor"]
	
	# if the boid is on a collision course with our boundaries,
	# adjust direction by the turning factor
	# Deviates from classic boids a bit. Could switch from Ray to
	# an Area3D or us the classic boids margin calculation
	if ray.is_colliding():
		var obj = ray.get_collider()
		if (obj.is_in_group("cage")):
			if obj.name == "Ceiling":
				v[1] -= boidParams["turnfactor"]

			if obj.name == "Floor":
				v[1] += boidParams["turnfactor"]

			if obj.name == "StageLeft":
				v[0] -= boidParams["turnfactor"]
				print("STAGELEFT")

			if obj.name == "StageRight":
				v[0] += boidParams["turnfactor"]

	# Look where you're going! Scaling made this more immediate *shrug*
	look_at(v*100, Vector3.UP, true)
	# enforce speed limits
	var speed = v.length()
	if speed < boidParams["minspeed"]:
		v = boidParams["minspeed"]*v/speed 
	elif speed > boidParams["maxspeed"]:
		v = boidParams["minspeed"]*v/speed 

	position += v*delta

