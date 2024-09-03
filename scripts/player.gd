extends CharacterBody2D


var arr1 = moveset_data.new().ExtractData()
var parse = arr1[0]
var moveset = arr1[1]

@onready var player_label: Label = %player_label

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#needs to be tranfered to a state machine/manager script
var previous_move: String
var current_array: Array
var string_passed: String


func _ready() -> void:
	
	
	current_array.resize(6)
	current_array.fill("0")

func UpdateCurrentMove(current_move) -> void:
	
	#print(parse)
	#print(parse["N0"]["kick (low right kick)"][1]["N1"]["kick (quick mid right kick)"][1]["N2"]["jump (resets character orientation mid air)"])
	#data["N0"][last_N0_value][1]["N1"][last_N1_value][1]["N2"][last_N2_value].append(temp3)
	
	if not "N0" in current_array:
		current_array[0] = "N0"
		current_array[1] = current_move
	elif not "N1" in current_array:
		current_array[2] = "N1"
		current_array[3] = current_move
	else:
		current_array[4] = "N2"
		current_array[5] = current_move
	#print(current_array)
		
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
