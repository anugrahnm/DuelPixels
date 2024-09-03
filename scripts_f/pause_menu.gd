extends Control
@onready var pause_menu1 = $"."

func resume():
	get_tree().paused = false
	pause_menu1.hide()
	
func pause():
	get_tree().paused = true
	pause_menu1.show()

func pause_menu():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		print("escape")
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused == true:
		resume()
		print("escape 2")
		
func _physics_process(_delta):
	pause_menu()


func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()
	


func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	resume()
	get_tree().change_scene_to_file("res://scenes_f/settings.tscn")
	
