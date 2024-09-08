extends CharacterBody2D

@onready var player_label: Label = %player_label
@onready var input_handler: Input_Handler = $Input_Handler

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var previous_move: String
var current_array: Array
var string_passed: String

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
	#print(current_array)
		
	string_passed = "".join(current_array)
	ChangeText(string_passed)

func ChangeText(string_passed) -> void:
	player_label.text = string_passed

func InputKeyReader() -> void:
	if Input.is_action_just_pressed("jump"):
		UpdateCurrentMove("jump")
	if Input.is_action_just_pressed("right"):
		UpdateCurrentMove("right")
	if Input.is_action_just_pressed("left"):
		UpdateCurrentMove("left")
	if Input.is_action_just_pressed("debugging_key"):
		pass

func _process(delta: float) -> void:
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
