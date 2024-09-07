extends Base_State
class_name State_1

@onready var player_label: Label = %player_label

func Enter() -> void:
	print("In State 1")
	player_label.text = "State_1"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self,"state_2")
