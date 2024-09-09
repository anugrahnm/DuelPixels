extends Node
class_name Data_Extractor


const JSON_FILE_PATH = "res://scripts_w/data.json"
var json_data

func ExtractData():
	var json_file_access = FileAccess.open(JSON_FILE_PATH, FileAccess.READ)
	json_data = JSON.parse_string(json_file_access.get_as_text())
	json_data.map(func(item): for key in item.keys(): item[key] = str(item[key]).to_lower())
	return json_data
