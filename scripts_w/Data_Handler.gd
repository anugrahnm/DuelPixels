extends Node
class_name Data_Handler

@onready var player: CharacterBody2D = get_parent()

var all_data : Array

const JSON_FILE_PATH = "res://scripts_w/data.json"
var json_data

func DataAll() -> Array:
	return all_data

func DataFilter(key, value, filter = [], exclude_value = false) -> Array:
	var temp_all_data : Array 
	if exclude_value:
		temp_all_data= all_data.filter(func(item): return not value in item[key])
	else:
		temp_all_data= all_data.filter(func(item): return value in item[key])
	if filter:
		temp_all_data = FormatData(temp_all_data,filter)
	return temp_all_data

func FormatData(temp_all_data,filter) -> Array:
	var temp2_all_data : Array
	for temp_item in temp_all_data:
		var temp2_item : Dictionary
		for f in filter:
			temp2_item[f]=temp_item[f]
		temp2_all_data.append(temp2_item)
	return temp2_all_data

func Transfer_All_Data_Plus_Extra_Combo_Breaker_Bool(current_move):
	var temp_unfiltered_next_possible_move : Array
	for single_data in all_data:
		var temp_single_next_possible_move : Dictionary
		if current_move["id"] == "":
			break
		temp_single_next_possible_move = single_data
		if single_data["id"] in current_move["next_possible_combo_list"]:
			temp_single_next_possible_move["combo_breaker"] = "false"
		else:
			temp_single_next_possible_move["combo_breaker"] = "true"
		temp_unfiltered_next_possible_move.append(temp_single_next_possible_move)
	return temp_unfiltered_next_possible_move

func HandleData(json_data: Array) -> void:
	for item in json_data:
		if item["id"] != "":
			all_data.append(item)

func ExtractData() -> Array:
	var json_file_access = FileAccess.open(JSON_FILE_PATH, FileAccess.READ)
	json_data = JSON.parse_string(json_file_access.get_as_text())
	json_data.map(func(item):LowerAndListify(item))
	return json_data

func LowerAndListify(item: Dictionary) -> Dictionary:
	for key in item.keys(): 
		item[key] = str(item[key]).to_lower()
		if "_list" in key:
			item[key] = item[key].split(",")
	return item

func Process(delta: float) -> void:
	player.unfiltered_next_possible_move = Transfer_All_Data_Plus_Extra_Combo_Breaker_Bool(player.current_move)
