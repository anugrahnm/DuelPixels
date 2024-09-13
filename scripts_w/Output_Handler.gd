extends Node
class_name Output_Handler

@onready var debug_label1: Label = $"../Debug/debug_label1"
@onready var debug_label2: Label = $"../Debug/debug_label2"
@onready var debug_label3: Label = $"../Debug/debug_label3"

@onready var player: CharacterBody2D = get_parent()

var previous_move: String
var current_array: Array
var string_passed: String

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity_strength_multiplier = 1.2

func Apply_Gravity(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta * gravity_strength_multiplier

func Get_Player_H_Direction(key_inputs: Array) -> int:
	var direction
	if "right" in key_inputs and not "left" in key_inputs:
		return 1
	elif not "right" in key_inputs and "left" in key_inputs:
		return -1
	else: 
		return 0

func Player_H_Movement_Function(direction: int) -> void:
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)

func Player_Jump_Function(key_inputs: Array) -> void:
	if "jump" in key_inputs and player.is_on_floor():
		player.velocity.y = JUMP_VELOCITY

func Process(delta: float) -> void:
	pass

func PhysicsProcess(delta: float) -> void:
	Apply_Gravity(delta)
	Player_Jump_Function(player.key_inputs)
	
	var direction = Get_Player_H_Direction(player.key_inputs) 
	Player_H_Movement_Function(direction)

	player.move_and_slide()
