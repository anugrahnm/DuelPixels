extends Control
@onready var option_tabs = $"Option Tabs"

var is_hidden: bool

### This is unfinished baselevel code to set be able to use the fn current_level_state
#const lever_state_options = {"inplay":"inplay","inpause":"inpause","inanimation":"inanimation"}
#var current_level_state = null
#
#func get_current_level_state():
	#if current_level_state == null:
		#push_error("current_level_state does not have a value, it needs to be set to one of " + str(lever_state_options.values()))
		#get_tree().quit()
		#return "you should not be able to read this line"
	#else:
		#return current_level_state 
#
#func set_current_level_state(new_current_level_state) -> void:
	#if new_current_level_state in lever_state_options:
		#current_level_state = lever_state_options[new_current_level_state]
	#else:
		#push_error("[" + new_current_level_state + "] not in lever_state_options")
####

func _ready():
	hide()
	is_hidden = true
	
func Enter() -> void :
	option_tabs.current_tab = 0
	show()
	is_hidden = true
	
func Exit() -> void :
	option_tabs.current_tab = 0
	hide()
	is_hidden = false
	
func check_if_hidden() -> bool :
	return is_hidden
	
	
