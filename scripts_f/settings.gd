extends Control
@onready var option_tabs = $"OptionTabs"
@onready var resolution_options= $"OptionTabs/General/DisplaySettings/ResolutionOptionButton"
@onready var master_volume = $"OptionTabs/General/SoundSettings/MasterVolume"
@onready var master_label = $"OptionTabs/General/SoundSettings/MasterVolume/Master_Volume"
@onready var music_volume = $"OptionTabs/General/SoundSettings/MusicVolume"
@onready var music_label = $"OptionTabs/General/SoundSettings/MusicVolume/Music_Volume"
@onready var sfx_volume= $"OptionTabs/General/SoundSettings/SFXVolume"
@onready var sfx_label = $"OptionTabs/General/SoundSettings/SFXVolume/SFX_Volume"
@onready var input_button_scene = preload("res://scenes_f/input_button.tscn")
@onready var action_list = $OptionTabs/KeyBinds/MarginContainer/VBoxContainer/ScrollContainer/ActionList

var is_remapping = false
var action_to_remap = null
var remapping_button = null

var input_actions = {
	"jump": "Jump",
	"left": "Left",
	"right": "Right",
	"punch": "Punch",
	"kick": "Kick",
	"heavy": "Heavy",
	"grab_interact": "Grab / Interact(Hold)",
	"roll_block": "Roll / Block(Hold)",
	"mute_game": "Mute Game"
	
}

var master = AudioServer.get_bus_index("Master")
var music= AudioServer.get_bus_index("Music")
var sfx= AudioServer.get_bus_index("SFX")

var is_hidden: bool
var current_resolution = [] 

func _ready():
	hide()
	is_hidden = true
	ShowSelfIfCurrentScene()
	GetCurrentResolution()
	GetVolume()
	CheckIfMute()
	CreateActionList()

func _process(_delta):
	IfMutePressed()
	ToggleIfMute()


func ShowSelfIfCurrentScene() -> void:
	if self == get_tree().get_current_scene():
		show()

func Enter() -> void :
	option_tabs.current_tab = 0
	show()
	is_hidden = true	

func Exit() -> void :
	option_tabs.current_tab = 0
	hide()
	is_hidden = false	

func check_if_hidden() -> bool :
	return is_hidden	

########KEY BINDING SETTINGS########
func CreateActionList():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("ActionLabel")
		var input_label = button.find_child("InputLabel")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size()>0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
			
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _input(event):
	if is_remapping:
		if event is InputEventKey and event.keycode == KEY_BACKSPACE:
			InputMap.action_erase_events(action_to_remap)
			UpdateActionList(remapping_button, null)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			accept_event()
			return
		elif event is InputEventKey || (event is InputEventMouseButton && event.pressed):	
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false 

			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			UpdateActionList(remapping_button, event)
		
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()

func UpdateActionList(button, event):
	if event == null:
		button.find_child("InputLabel").text = ""
	else:
		button.find_child("InputLabel").text = event.as_text().trim_suffix(" (Physical)")

####################################

##########DISPLAY SETTINGS##########
func GetCurrentResolution():
	current_resolution = DisplayServer.window_get_size(0)
	print(current_resolution)

func ResolutionSelect(index):
	var resolution: String = resolution_options.get_item_text(index)
	var h_resolution: int = int(resolution.get_slice("x", 0))
	var v_resolution: int = int(resolution.get_slice("x", 1))
	DisplayServer.window_set_size(Vector2i(h_resolution, v_resolution))
	current_resolution = [h_resolution,v_resolution]
	print(current_resolution)

func WindowModeSelect(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			print("Fullscreen")
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(current_resolution[0], current_resolution[1]))
			print("Windowed")

func VSyncToggle(toggled_on):
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		print("V-Sync On")
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		print("V-Sync Off")

func BorderlessToggle(toggled_on):
	if toggled_on:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
		print("Borderless On")
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		print("Borderless Off")

####################################

#########AUDIO SETTINGS#############
func CheckIfMute():
	if $"OptionTabs/General/SoundSettings/MuteCheckBox".button_pressed:
		AudioServer.set_bus_mute(0, true)
		print("Game Muted")

func ToggleIfMute():
	if AudioServer.is_bus_mute(0) == true:
		$"OptionTabs/General/SoundSettings/MuteCheckBox".button_pressed = true
	else:
		$"OptionTabs/General/SoundSettings/MuteCheckBox".button_pressed = false

func IfMutePressed():
	if Input.is_action_just_pressed("mute_game") && AudioServer.is_bus_mute(0) == false:
		AudioServer.set_bus_mute(0, true)
		#print("MuteWorking")
	elif Input.is_action_just_pressed("mute_game"):
		AudioServer.set_bus_mute(0, false)
		#print("UnMuteWorking")

func GetVolume():
	master_volume.value = db_to_linear(AudioServer.get_bus_volume_db(master))
	music_volume.value = db_to_linear(AudioServer.get_bus_volume_db(music))
	sfx_volume.value = db_to_linear(AudioServer.get_bus_volume_db(sfx))

func MuteToggle(toggled_on):
	if toggled_on:
		AudioServer.set_bus_mute(0, true)
		print("Game Muted")
	else:
		AudioServer.set_bus_mute(0, false)
		print("Game Unmuted")

func MasterVolumeSlider(value):
	master_label.text = str(value * 100)
	AudioServer.set_bus_volume_db(master, linear_to_db(value))

func MusicVolumeSlider(value):
	music_label.text = str(value * 100)
	AudioServer.set_bus_volume_db(music, linear_to_db(value))

func SFXVolumeSlider(value):
	sfx_label.text = str(value * 100)
	AudioServer.set_bus_volume_db(sfx, linear_to_db(value))

####################################

#########SIGNAL CONNECTIONS#########
func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("InputLabel").text = "Press Key To Bind..."

func _on_reset_button_pressed():
	CreateActionList()

func _on_resolution_option_button_item_selected(index):
	ResolutionSelect(index)

func _on_window_option_button_item_selected(index):
	WindowModeSelect(index)

func _on_v_sync_check_box_toggled(toggled_on):
	VSyncToggle(toggled_on)

func _on_borderless_check_box_toggled(toggled_on):
	BorderlessToggle(toggled_on)

func _on_mute_check_box_toggled(toggled_on):
	MuteToggle(toggled_on)

func _on_master_volume_value_changed(value):
	MasterVolumeSlider(value)

func _on_music_volume_value_changed(value):
	MusicVolumeSlider(value)

func _on_sfx_volume_value_changed(value):
	SFXVolumeSlider(value)
####################################
