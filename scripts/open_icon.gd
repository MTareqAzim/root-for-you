extends Control

var cheers : Array = ["heal", "block", "attack", "magic"]

func _ready():
	for index in cheers.size():
		get_child(index).material.set_shader_param("base_color",
				Settings.get_color_from_key(cheers[index]))
