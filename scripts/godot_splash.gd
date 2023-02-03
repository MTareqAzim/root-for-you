extends Control

export(float) var fade_in_delay := 1.0
export(float) var fade_in_time := 2.0
export(float) var fade_out_delay := 3.0
export(float) var fade_out_time := 1.5
export(String, FILE, "*.tscn") var scene_to_preload

onready var logo = $GodotLogo
onready var tween = $Tween


func _ready():
	logo.modulate = Color.transparent


func poll_preload_scene() -> void:
	get_viewport().preload_scene(scene_to_preload)
	_set_up_and_start_tween()


func _set_up_and_start_tween() -> void:
	var fade_out_final_delay := fade_in_delay + fade_in_time + fade_out_delay
	var change_scene_delay := fade_out_final_delay + fade_out_time
	
	tween.interpolate_property(logo, "modulate", Color.transparent, Color.white, fade_in_time,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, fade_in_delay)
	tween.interpolate_property(logo, "modulate", Color.white, Color.transparent, fade_out_time,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, fade_out_final_delay)
	tween.interpolate_deferred_callback(get_viewport(), change_scene_delay, "change_to_preloaded_scene")
	
	tween.start()
