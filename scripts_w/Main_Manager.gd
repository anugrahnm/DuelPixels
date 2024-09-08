extends Node
class_name Main_Manager

const JSON_FILE_PATH = "res://scripts_w/data2.json"
const EMPTY = ""

var json_file_access
var json_data
var data : Array


func ExtractData():
    json_file_access = FileAccess.open(JSON_FILE_PATH, FileAccess.READ)
    json_data = JSON.parse_string(json_file_access.get_as_text())

func FormatData():
    for json_item in json_data:
        if json_item["id"]:
            data.append(Data_Handler.new(json_item))

func SearchInData(key_name,value):
    for item in data:
        if item.all[key_name] == value:
            print(item.all)

func _ready() -> void:
    ExtractData()
    FormatData()
