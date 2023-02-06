extends Control

var cheer : String
var is_pronounced : bool

onready var icon : TextureRect = $Icon

var texture : Texture


func _ready():
	if cheer == "open":
		icon.hide()
		var open_icon = load("res://scenes/ui_scenes/open_icon.tscn").instance()
		add_child(open_icon)
	else:
		icon.texture = texture
		icon.material.set_shader_param("base_color", Settings.get_color_from_key(cheer))
	
	var pronounced = $Pronounced
	pronounced.material.set_shader_param("base_color", Settings.get_color_from_key("beat"))
	
	pronounced.show() if is_pronounced else pronounced.hide()
