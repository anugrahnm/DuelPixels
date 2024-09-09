extends Node
class_name Executer

@onready var debug_label: Label = $"../Debug/debug_label"
@onready var player: CharacterBody2D = get_parent()

var previous_move: String
var current_array: Array
var string_passed: String

func _ready() -> void:
	current_array.resize(7)
	current_array.fill("")

func ChangeDebugText(string_passed: String) -> void:
	debug_label.text = string_passed

func UpdateDebugText(current_move) -> void:
	current_array[0] = "[ "
	current_array[6] = " ]"
	if not current_array[1]:
		current_array[1] = current_move
	elif not current_array[3]:
		current_array[2] = " > "
		current_array[3] = current_move
	else:
		if current_array[5]:
			current_array[1] = current_array[3]
			current_array[3] = current_array[5]
		current_array[4] = " > "
		current_array[5] = current_move
		
	string_passed = "".join(current_array)
	ChangeDebugText(string_passed)

func PhysicsProcess(delta,key_inputs):
	if key_inputs:
		#print(key_inputs)
		#player.input_keys = []
		pass
