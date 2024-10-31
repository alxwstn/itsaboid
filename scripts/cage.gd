extends Node3D


# Called when the node enters the scene tree for the first time.
func initialize(xbounds: Vector2, ybounds: Vector2, zbounds: Vector2):
	$Floor.position.y = ybounds[0]
	$Back.position.z = zbounds[0]
	$StageRight.position.x = xbounds[0]
	
	$Ceiling.position.y = ybounds[1]
	$Front.position.z = zbounds[1]
	$StageLeft.position.x = xbounds[1]
