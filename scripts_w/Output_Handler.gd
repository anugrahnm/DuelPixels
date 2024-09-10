extends Node
class_name Output_Handler

@onready var debug_label: Label = $"../Debug/debug_label"
@onready var player: CharacterBody2D = get_parent()

var previous_move: String
var current_array: Array
var string_passed: String

const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var gravity_strength = 0.8

func ChangeDebugText(string_passed: String) -> void:
	debug_label.text = string_passed

func UpdateDebugText(current_move) -> void:
	if len(current_array) == 0:
		current_array.resize(7)
		current_array.fill("")
		
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

func Apply_Gravity(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta * gravity_strength

func Get_Player_H_Direction(key_inputs) -> int:
	var direction
	if "right" in key_inputs and not "left" in key_inputs:
		return 1
	elif not "right" in key_inputs and "left" in key_inputs:
		return -1
	else: 
		return 0

func Player_H_Movement_Function(direction) -> void:
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)

func Player_Jump_Function(key_inputs) -> void:
	if "jump" in key_inputs and player.is_on_floor():
		player.velocity.y = JUMP_VELOCITY

func PhysicsProcess(delta,key_inputs) -> void:
	Apply_Gravity(delta)
	Player_Jump_Function(key_inputs)
	
	var direction = Get_Player_H_Direction(key_inputs) 
	Player_H_Movement_Function(direction)

	player.move_and_slide()
