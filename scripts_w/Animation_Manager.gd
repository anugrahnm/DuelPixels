extends Node
class_name Animation_Manager

const json_file_path = "res://scripts_w/data2.json"

var json_file_access
var json_data

func ExtractData():
	json_file_access = FileAccess.open(json_file_path, FileAccess.READ)
	json_data = JSON.parse_string(json_file_access.get_as_text())

func FormatData():
	pass

func _ready() -> void:
	ExtractData()
	FormatData()
