extends Control
@onready var option_tabs = $"Option Tabs"
@onready var resolution_options= $"Option Tabs/General/DisplaySettings/ResolutionOptionButton"

var is_hidden: bool


func _ready():
	hide()
	is_hidden = true
	ShowSelfIfCurrentScene()

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
	
	


func _on_resolution_option_button_item_selected(index):
	var resolution: String = resolution_options.get_item_text(index)
	var h_resolution: int = int(resolution.get_slice("x", 0))
	var v_resolution: int = int(resolution.get_slice("x", 1))
	DisplayServer.window_set_size(Vector2i(h_resolution, v_resolution))


func _on_window_option_button_2_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		


func _on_v_sync_check_box_toggled(toggled_on):
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	

func _on_borderless_check_box_toggled(toggled_on):
	pass # Replace with function body.
