extends Node
class_name Input_Handler

@onready var player: CharacterBody2D = get_parent()
@onready var executer : Executer = %Executer
var restricted_input: Array

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var previous_move: String
var current_array: Array
var string_passed: String

var all_inputs = ["right","left","jump","punch","kick","heavy","grab_interact","roll_block","debugging_key"]
var debug_ignore = ["right","left","debugging_key"]

func _ready() -> void:
	current_array.resize(7)
	current_array.fill("")

func UpdateCurrentMove(current_move) -> void:
	current_array[0] = "[ "
	current_array[6] = " ]"
	if not current_array[1]:
		current_array[1] = current_move
	elif not current_array[3]:
		current_array[2] = ">"
		current_array[3] = current_move
	else:
		if current_array[5]:
			current_array[1] = current_array[3]
			current_array[3] = current_array[5]
		current_array[4] = ">"
		current_array[5] = current_move
		
	string_passed = "".join(current_array)
	executer.ChangeText(string_passed)

func InputKeyReader() -> void:
	for i in all_inputs:
		if Input.is_action_just_pressed(i) and not i in debug_ignore:
			UpdateCurrentMove(i)

func Update(delta: float) -> void:
	if restricted_input:
		print(restricted_input)
	InputKeyReader()

func PhysicsUpdate(delta: float) -> void:
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)

	player.move_and_slide()
