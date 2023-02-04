extends Control

enum Options {START, SETTINGS, CREDITS}

export(Array, String, FILE, "*.tscn") var next_scenes

onready var backgrounds : Array = [ $CenterContainer/Start/bg,
		$CenterContainer/Settings/bg,
		$CenterContainer/Credits/bg
]

var current_option : int = Options.START

const hover_color : Color = Color("648a8a00")
const base_color : Color = Color("64000000")


func _ready():
	_set_bg()
	get_viewport().call_deferred("preload_scene", next_scenes[Options.START])


func _input(event):
	if event.is_action_pressed("ui_accept"):
		if current_option == Options.START:
			get_viewport().call_deferred("change_to_preloaded_scene")
		else:
			get_viewport().call_deferred("change_scene", next_scenes[current_option])
	
	var next : int = int(event.is_action_pressed("ui_down")) - int(event.is_action_pressed("ui_up"))
	
	if next == 0:
		return
	
	current_option = posmod((current_option + next), backgrounds.size())
	_set_bg()


func _set_bg():
	for index in backgrounds.size():
		if index == current_option:
			backgrounds[index].color = hover_color
		else:
			backgrounds[index].color = base_color
