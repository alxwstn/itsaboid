extends StaticBody3D

class_name Boid

# "velocity" of our static body
var v = Vector3(randf_range(-1.0, 1.0),randf_range(-1.0, 1.0),0)

var boidParams
@onready
var area = $Area3D
const area_radius = .5

# inintialize the boid with a reference to the flock parameters
func initialize(_boidParams, _position):
	boidParams = _boidParams
	position = _position
	var shape = $Area3D/CollisionShape3D.shape
	shape.radius = area_radius
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
	
	# if the boid is within area_radius of our boundaries,
	# adjust direction by the turning factor
	if area.has_overlapping_bodies():
		var bodies = area.get_overlapping_bodies()
		for obj in bodies:
			if obj.name == "Ceiling":
				v[1] -= boidParams["turnfactor"]

			elif obj.name == "Floor":
				v[1] += boidParams["turnfactor"]

			elif obj.name == "StageLeft":
				v[0] -= boidParams["turnfactor"]

			elif obj.name == "StageRight":
				v[0] += boidParams["turnfactor"]

	# Look where you're going! Scaling this take effect more immediately *shrug*
	look_at(v*100, Vector3.UP, true)
	# enforce speed limits
	var speed = v.length()
	if speed < boidParams["minspeed"]:
		v = boidParams["minspeed"]*v/speed 
	elif speed > boidParams["maxspeed"]:
		v = boidParams["minspeed"]*v/speed 

	position += v*delta

