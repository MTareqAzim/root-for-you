extends Control

signal cheer(cheer)

export(Array, String, FILE, "*.tscn") var layouts
var layout : Control


func _ready() -> void:
	if Settings.layout > layouts.size():
		return
	
	layout = load(layouts[Settings.layout]).instance()
	var _error = layout.connect("cheered", self, "_cheer")
	
	add_child(layout)


func _cheer(cheer: String) -> void:
	emit_signal("cheer", cheer)
