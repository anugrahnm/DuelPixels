extends Node
class_name Input_Handler

@onready var player: CharacterBody2D = $".."
var restricted_input: Array

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("punch"):
		print("punch")
	if not restricted_input:
		print("empty restrictions")
