extends TextureRect

var cheer : String
var is_pronounced : bool


func _ready():
	material.set_shader_param("base_color", Settings.get_color_from_key(cheer))
	
	var pronounced = $Pronounced
	pronounced.material.set_shader_param("base_color", Settings.get_color_from_key("beat"))
	
	pronounced.show() if is_pronounced else pronounced.hide()
