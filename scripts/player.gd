extends CharacterBody2D

var moveset = moveset_data.new().data

@onready var player_label: Label = %player_label

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func ChangeText(string_string) -> void:
	player_label.text = string_string
	
func InputKeyReader() -> void:
	if Input.is_action_just_pressed("jump"):
		ChangeText("jump")
	if Input.is_action_just_pressed("right"):
		ChangeText("right")
	if Input.is_action_just_pressed("left"):
		ChangeText("left")
	if Input.is_action_just_pressed("debugging_key"):
		ChangeText(moveset)
		
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
