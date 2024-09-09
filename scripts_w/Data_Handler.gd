extends Node
class_name Data_Handler
var all :Array

func HandleData(json_data) -> void:
	for item in json_data:
		if item["id"] != "":
			all.append(item)

func DataAll():
	return all
	
func DataFilter(key = null, value = null, filter = []):
	if key and value:
		var temp_all : Array = all.filter(func(item): return item[key] == value)
		if filter:
			temp_all = FormatData(temp_all,filter)
		return temp_all

func FormatData(temp_all,filter):
	var temp2_all : Array
	for temp_item in temp_all:
		var temp2_item : Dictionary
		for f in filter:
			temp2_item[f] = temp_item[f]
		temp2_all.append(temp2_item)
	return temp2_all
