extends CharacterBody2D

@onready var player_label: Label = %player_label

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

func ChangeText(string_string):
	player_label.text = string_string

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		ChangeText("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		match direction:
			1:ChangeText("right")
			-1:ChangeText("left")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
