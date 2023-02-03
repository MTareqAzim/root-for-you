extends Control

export(String, FILE, "*.tscn") var scene_to_preload


func poll_preload_scene() -> void:
	if scene_to_preload:
		get_viewport().preload_scene(scene_to_preload)
