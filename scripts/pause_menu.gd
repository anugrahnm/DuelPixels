extends CanvasLayer
@onready var panel_container = $PanelContainer

func resume():
	get_tree().paused = false
	panel_container
	
func pause():
	get_tree().paused = true

func pause_menu():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused == true:
		resume()
		
func _physics_process(_delta):
	pause_menu()


func _on_resume_pressed():
	resume()
	
