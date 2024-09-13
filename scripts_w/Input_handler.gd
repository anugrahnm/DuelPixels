extends Node
class_name Input_Handler

@onready var player: CharacterBody2D = get_parent()

var all_inputs = ["right","left","jump","punch","kick","heavy","grab_interact","roll_block"]
var movement_only_inputs = ["right","left"]
var holdable_input = ["right","left","grab_interact","roll_block"]
var only_allowed_input = []
var local_combo_tracker : Array
var local_current_move : String

func Set_Local_Current_Move(key, filtered_next_possible_move) -> void:
	local_current_move = filtered_next_possible_move[key]

func Find_The_Right_Key(key, filtered_next_possible_move) -> String:
	if key in movement_only_inputs:
		return key
	elif key in filtered_next_possible_move.keys():
		Set_Local_Current_Move(key, filtered_next_possible_move)
		local_combo_tracker.append(filtered_next_possible_move[key])
		return key
	else:
		Set_Local_Current_Move(key, filtered_next_possible_move)
		local_combo_tracker = []
		return key

func InputKeyReader(filtered_next_possible_move, restricted_input) -> Array:
	var temp_key_inputs : Array = []
	if only_allowed_input:
		all_inputs = only_allowed_input
		
	for key in all_inputs:
		if key in restricted_input:
			continue
		
		if Checks_If_Player_Presses_Unholdable_Input(key) or Checks_If_Player_Holds_Holdable_Input(key):
			temp_key_inputs.append(Find_The_Right_Key(key, filtered_next_possible_move))
	
	if temp_key_inputs:
		print(temp_key_inputs)
		print(local_combo_tracker)
	
	return temp_key_inputs

func Checks_If_Player_Presses_Unholdable_Input(key) -> bool:
	return not key in holdable_input and Input.is_action_just_pressed(key)

func Checks_If_Player_Holds_Holdable_Input(key) -> bool:
	return key in holdable_input and Input.is_action_pressed(key)

func Process(delta: float) -> void:
	player.key_inputs = InputKeyReader(player.filtered_next_possible_move, player.restricted_input)
	if player.current_move and local_current_move:
		print(player.current_move)
		player.current_move = local_current_move
