extends Node
class_name State_Manager

@export var initial_state: Base_State
var current_state : Base_State
var states : Dictionary


func _ready() -> void:
	print("State_Manager Bootup")
	for child in get_children():
		if child is Base_State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
		
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func on_child_transition(state,new_state_name):
	if !current_state or state != current_state:
		print("error")
		return
	
	var new_state = states.get(new_state_name.to_lower())
	
	current_state.Exit()
	new_state.Enter()
	current_state = new_state
	
func _process(delta: float) -> void:
	if current_state:
		current_state.process(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.process(delta)
