extends Node
class_name Stat_Handler

@onready var player: CharacterBody2D = get_parent()

var tempbool = true

func Check_If_Gravity_Should_Apply() -> bool:
	return not player.is_on_floor()

func Check_If_Player_Cannot_Jump() -> bool:
	return not player.is_on_floor()

func Filter_The_Unfiltered_Next_Possible_Move(unfiltered_next_possible_move: Array) -> Array :
	#Just a place holder for now
	var filtered_next_possible_move = unfiltered_next_possible_move
	if tempbool:
		print(filtered_next_possible_move)
	tempbool = false
	return filtered_next_possible_move

func Process(delta: float) -> void:
	player.apply_gravity = Check_If_Gravity_Should_Apply()
	if Check_If_Player_Cannot_Jump():
		player.restricted_input.append("jump")
	player.filtered_next_possible_move = Filter_The_Unfiltered_Next_Possible_Move(player.unfiltered_next_possible_move)
