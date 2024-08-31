extends CharacterBody2D

var moveset = moveset_data.new().DATA

@onready var player_label: Label = %player_label

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#needs to be tranfered to a state machine/manager script
var previous_move: String = ""
var current_array: Array
var string_passed = ""

func UpdateCurrentMove(current_move) -> void:
	
	for i in 20:
		current_array.append(str(i))
	
	current_array = current_move.split(".")
	
	if not "N0" in current_array:
		#current_array[0] = "N0"
		#current_array[1] = current_move
		pass
	print(current_array)
		
	string_passed = ".".join(current_array)
	ChangeText(string_passed)
	
func ChangeText(string_passed) -> void:
	player_label.text = string_passed
#

	
func InputKeyReader() -> void:
	if Input.is_action_just_pressed("jump"):
		UpdateCurrentMove("jump")
	if Input.is_action_just_pressed("right"):
		UpdateCurrentMove("right")
	if Input.is_action_just_pressed("left"):
		UpdateCurrentMove("left")
	if Input.is_action_just_pressed("debugging_key"):
		UpdateCurrentMove(moveset)
		
func _process(delta: float) -> void:
	if delta != 0:
		InputKeyReader()

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
