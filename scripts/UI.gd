extends Control

signal state_reset(state)
# todo put this initial state in an autoload
var form_state = {
	"flockSize": "3"
}


func _on_cancel_pressed():
	$Settings.visible = false


func _on_settings_btn_pressed():
	# load settings values	
	$Settings.visible = true
	%FlockSizeInput.text = form_state["flockSize"]

func _on_update_pressed():
	# probs would need form validation/handling
	form_state = {
		"flockSize": %FlockSizeInput.text 
	}
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
		"flockSize": (form_state["flockSize"] as int)
	}
	$Settings.visible = false
	state_reset.emit(state)
	
