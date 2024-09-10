extends Node
class_name Input_Handler

@onready var player: CharacterBody2D = get_parent()

var all_inputs = ["right","left","jump","punch","kick","heavy","grab_interact","roll_block","debugging_key"]
var debug_ignore = ["right","left","debugging_key"]
var holdable_input = ["right","left","grab_interact","roll_block"]
var only_allowed_input = []
var restricted_input = []

func InputKeyReader() -> void:
	if only_allowed_input:
		all_inputs = only_allowed_input
		
	for key in all_inputs:
		if Checks_If_Player_Presses_Unholdable_Input(key) or Checks_If_Player_Holds_Holdable_Input(key) :
			player.key_inputs.append(key)
			if not key in debug_ignore:
				player.UpdateDebugText(key)

func Checks_If_Player_Presses_Unholdable_Input(key) -> bool:
	return not key in holdable_input and Input.is_action_just_pressed(key) and not key in restricted_input
	
func Checks_If_Player_Holds_Holdable_Input(key) -> bool:
		return key in holdable_input and Input.is_action_pressed(key) and not key in restricted_input

func PhysicsProcess(delta: float) -> void:
	InputKeyReader()
