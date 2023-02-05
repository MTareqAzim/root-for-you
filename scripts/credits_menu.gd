extends Control

export(String, FILE, "*.tscn") var main_menu


func _ready():
	if get_viewport().has_method("preload_scene"):
		get_viewport().call_deferred("preload_scene", main_menu)


func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
		get_viewport().call_deferred("change_to_preloaded_scene")
