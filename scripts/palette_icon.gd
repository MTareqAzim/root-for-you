extends TextureRect

export(String) var key


func _ready():
	refresh_color()


func refresh_color():
	var color = Settings.get_color_from_key(key)
	material.set_shader_param("base_color", color)
