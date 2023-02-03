extends Viewport

var preloaded_scene : Node


func _ready():
	var current_scene = get_child(0)
	current_scene.call_deferred("poll_preload_scene")


func change_scene(path: String) -> void:
	var new_scene_resource = load(path)
	var new_scene = new_scene_resource.instance()
	
	if not new_scene:
		return
	
	get_child(0).queue_free()
	add_child(new_scene)
	
	_clear_preloaded_scene()


func change_to_preloaded_scene() -> void:
	if not preloaded_scene:
		return
	
	get_child(0).queue_free()
	add_child(preloaded_scene)
	
	_clear_preloaded_scene()


func preload_scene(path: String) -> void:
	_clear_preloaded_scene()
	
	var new_scene_resource = load(path)
	preloaded_scene = new_scene_resource.instance()


func _clear_preloaded_scene() -> void:
	if not preloaded_scene:
		return
	
	preloaded_scene.free()
	preloaded_scene = null
