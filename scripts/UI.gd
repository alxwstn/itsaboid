extends Control

signal state_reset(state)
var form_state

func initialize(_boidParams):
	form_state = _boidParams

func _on_cancel_pressed():
	$Settings.visible = false

func _on_settings_btn_pressed():
	# load settings values	
	$Settings.visible = true
	%TurnFactorInput.text =  str(form_state["turnfactor"])
	%VisualRangeInput.text = str(form_state["visualRange"])
	%ProtectedRangeInput.text = str(form_state["protectedRange"])
	%CenteringFactorInput.text = str(form_state["centeringfactor"])
	%AvoidFactorInput.text = str(form_state["avoidfactor"])
	%MatchingFactorInput.text = str(form_state["matchingfactor"])
	%MaxSpeedInput.text = str(form_state["maxspeed"])
	%MinSpeedInput.text = str(form_state["minspeed"])
	%FlockSizeInput.text = str(form_state["flockSize"])

func _on_update_pressed():
	# we SHOULD add form validation and error handling

	form_state = {
		"boids": [],
		"turnfactor": %TurnFactorInput.text as float,
		"visualRange": %VisualRangeInput.text as float,
		"protectedRange": %ProtectedRangeInput.text as float,
		"centeringfactor": %CenteringFactorInput.text as float,
		"avoidfactor": %AvoidFactorInput.text as float,
		"matchingfactor": %MatchingFactorInput.text as float,
		"maxspeed": %MaxSpeedInput.text as float,
		"minspeed": %MinSpeedInput.text as float,
		"flockSize": (%FlockSizeInput.text as int)
	}

	print("Restarting with parameters:")
	print(JSON.stringify(form_state,'\t'))
	$Settings.visible = false
	state_reset.emit(form_state)
	
