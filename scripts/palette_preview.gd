extends Control

onready var hbc = $HBC


func refresh_preview() -> void:
	for child in hbc.get_children():
		if child.has_method("refresh_color"):
			child.call("refresh_color")
