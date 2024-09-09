extends Node
class_name Data_Handler
var all :Array

func _ready() -> void:
	pass

func HandleData(json_data) -> void:
	for item in json_data:
		if item["id"] != "":
			all.append(item)

func DataAll():
	return all
	
func DataFilter(key = null, value = null, filter = [], compress_results = false):
	if key and value:
		var temp_all : Array = all.filter(func(item): return item[key] == value)
		if filter:
			temp_all = FormatData(temp_all,filter,compress_results)
		return temp_all

func FormatData(temp_all,filter,compress_results):
	var temp2_all : Array
	for temp_item in temp_all:
		var temp2_item
		if compress_results or temp_item is Dictionary:
			temp2_item = []
		else:
			temp2_item = {}
			
		for f in filter:
			temp2_item.append(temp_item[f])
		temp2_all.append(temp2_item)
		
	return temp2_all
