extends Node
class_name Input_Handler

@onready var player: CharacterBody2D = get_parent()
@onready var executer : Executer = %Executer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var all_inputs = ["right","left","jump","punch","kick","heavy","grab_interact","roll_block","debugging_key"]
var debug_ignore = ["right","left","debugging_key"]
var restricted_input = []

func InputKeyReader() -> void:
	for i in all_inputs:
		if Input.is_action_just_pressed(i) and not i in restricted_input:
			player.key_inputs.append(i)
			if not i in debug_ignore:
				executer.UpdateDebugText(i)
	#for i in player.ShowNextPossibleMoveOfId("p1"):
		#executer.UpdateDebugText(i)
		
func Process(delta: float) -> void:
	InputKeyReader()

func PhysicsProcess(delta: float) -> void:
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and player.is_on_floor() and not "jump" in restricted_input:
		player.velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)

	player.move_and_slide()
