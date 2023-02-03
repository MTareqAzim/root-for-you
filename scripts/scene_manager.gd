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
	
	preloaded_scene.queue_free()
	preloaded_scene = null


func change_to_preloaded_scene() -> void:
	if not preloaded_scene:
		return
	
	get_child(0).queue_free()
	add_child(preloaded_scene)
	
	preloaded_scene = null


func preload_scene(path: String) -> void:
	if preloaded_scene:
		if not preloaded_scene.is_inside_tree():
			preloaded_scene.queue_free()
	
	var new_scene_resource = load(path)
	preloaded_scene = new_scene_resource.instance()
