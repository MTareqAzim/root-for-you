extends Control

export(float) var fade_in_delay := 1.0
export(float) var fade_in_time := 2.0
export(float) var fade_out_delay := 3.0
export(float) var fade_out_time := 1.0

export(float) var at_least_time := 0.5

export(String, FILE, "*.tscn") var scene_to_preload

onready var logo = $Logo
onready var tween = $Tween


func _ready():
	logo.modulate = Color.transparent
	call_deferred("_preload_scene")


func _input(event):
	if event.is_action_pressed("start"):
		if not tween.is_active():
			return
		
		var time_to_skip : float = fade_in_delay + fade_in_time + fade_out_delay - at_least_time
		var total_time : float = fade_in_delay + fade_in_time + fade_out_delay + fade_out_time - 0.05
		
		if tween.tell() <= time_to_skip:
			tween.seek(time_to_skip)
		elif tween.tell() <= total_time:
			tween.seek(total_time)


func _preload_scene() -> void:
	if get_viewport().has_method("preload_scene"):
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
