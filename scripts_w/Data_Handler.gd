extends Node
class_name Data_Handler

var all : Array

const JSON_FILE_PATH = "res://scripts_w/data.json"
var json_data

func DataAll() -> Array:
	return all

func DataFilter(key, value, filter = [], exclude_value = false) -> Array:
	var temp_all : Array 
	if exclude_value:
		temp_all= all.filter(func(item): return not value in item[key])
	else:
		temp_all= all.filter(func(item): return value in item[key])
	if filter:
		temp_all = FormatData(temp_all,filter)
	return temp_all

func FormatData(temp_all,filter) -> Array:
	var temp2_all : Array
	for temp_item in temp_all:
		var temp2_item : Dictionary
		for f in filter:
			temp2_item[f]=temp_item[f]
		temp2_all.append(temp2_item)
	return temp2_all

func HandleData(json_data) -> void:
	for item in json_data:
		if item["id"] != "":
			all.append(item)

func ExtractData() -> Array:
	var json_file_access = FileAccess.open(JSON_FILE_PATH, FileAccess.READ)
	json_data = JSON.parse_string(json_file_access.get_as_text())
	json_data.map(func(item):LowerAndListify(item))
	return json_data

func LowerAndListify(item) -> Dictionary:
	for key in item.keys(): 
		item[key] = str(item[key]).to_lower()
		if "_list" in key:
			item[key] = item[key].split(",")
	return item
