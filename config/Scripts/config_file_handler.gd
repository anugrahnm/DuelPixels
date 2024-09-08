extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"


func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		pass
