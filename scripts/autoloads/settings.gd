extends Node

enum Layout {CORNER, TRIGGER, FACE}
enum Volume {MASTER, BEATS, CROWD, CHARACTERS}

var layout : int = Layout.TRIGGER
var palette : int = 0
var volume : Array = [100, 100, 100, 100]

const default_color : Color = Color("#303030")

var palettes : Array = [
	{
		"heal": "#00ff00",
		"block": "#ffff00",
		"attack": "#ff0000",
		"magic": "#0000ff",
		"crowd": "#ff9900",
		"beats": "#8080ff",
		"player": "#5cda5c",
		"villain": "#990000",
	}
]


func _ready():
	_load_palettes()


func _load_palettes() -> void:
	var file = File.new()
	file.open("res://assets/palettes.json", File.READ)
	var json_string = file.get_as_text()
	file.close()
	
	var json_parse = JSON.parse(json_string)
	if typeof(json_parse.result) == TYPE_ARRAY:
		palettes = json_parse.result


func get_color_from_key(key: String) -> Color:
	var current_palette : Dictionary = palettes[palette]
	if current_palette.has(key):
		return Color(current_palette[key])
	
	return default_color
