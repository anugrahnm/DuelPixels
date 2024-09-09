extends Node
class_name Executer

@onready var player_label: Label = $"../Debug_text/player_label"

func ChangeText(string_passed: String) -> void:
	player_label.text = string_passed
