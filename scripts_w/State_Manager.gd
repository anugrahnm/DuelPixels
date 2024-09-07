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
	current_state.testvar = "hello"

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

### For the baselevel
#@export var pause_menu = "$pause_menu"

#var info_passed_down_list = [pause_menu]
#const level_state_options = {"inplay":"inplay","inpause":"inpause","inanimation":"inanimation"}
#@export var current_level_state = Enum(level_state_options.keys())

#func _ready():
#	for item in info_passed_down_list:
		#item.set_current_level_state_signal.connect(set_current_level_state)

#func get_current_level_state():
#if current_level_state == null:
	#push_error("current_level_state does not have a value, it needs to be set to one of " + str(level_state_options.values()))
	#get_tree().quit()
	#return "you should not be able to read this line"
#else:
	#return current_level_state 

#func set_current_level_state(new_current_level_state) -> void:
	#if new_current_level_state in level_state_options:
		#if current_level_state == null
			#current_level_state = level_state_options[new_current_level_state]
	#else:
		#push_error("[" + new_current_level_state + "] not in level_state_options")

#func pass_down_info():
#	for item in info_passed_down_list:
#		item.current_level_state = get_current_level_state():

#add this under _process
#pass_down_info()

#add this under pause_menu canvas script
#var current_level_state
#
#signal set_current_level_state_signal
#
#func set_current_level_state(name_of_state):
#	set_current_level_state_signal.emit(name_of_state)

#to use this under any child scene under canvas use
#reference_to_canvas.set_current_level_state("inpause")
#reference_to_canvas.current_level_state
###
