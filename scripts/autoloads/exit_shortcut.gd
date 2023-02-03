extends Node


func _ready():
	if OS.get_name() != "Unix":
		queue_free()


func _input(event):
	if event.is_action_pressed("start"):
		if Input.is_action_pressed("back"):
			_exit()
	
	if event.is_action_pressed("back"):
		if Input.is_action_pressed("start"):
			_exit()


func _exit():
	get_tree().set_input_as_handled()
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
