extends CanvasLayer

@onready var menu = $pause_menu
@onready var settings = $Settings

enum state {playing, on_pause, in_cutscene, loading_screen}
var states = state.playing

var is_hidden: bool

func _ready():
	menu.hide()
	is_hidden = true

func resume():
	get_tree().paused = false
	menu.hide()
	settings.Exit()

func OnPause():
	settings.Exit()
	get_tree().paused = true
	menu.show()

func pause_menu():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		print("escape")
		OnPause()
	elif Input.is_action_just_pressed("escape") and !settings.check_if_hidden():
		resume()
		print("escape 2")
	elif Input.is_action_just_pressed("escape") and settings.check_if_hidden():
		OnPause()
		
func _physics_process(_delta):
	pause_menu()

func _on_resume_pressed():
	resume()
	print("resume")

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	menu.hide()
	settings.Enter()

func _on_back_pressed():
	OnPause()
