extends Control

signal beat

export(bool) var enabled := true setget set_enabled
export(int) var beats_per_minute := 90 setget set_beats_per_minute
export(bool) var pronounced_beats := false
export(int, 1, 100) var time_signature := 4
export(float, 0.0, 0.5) var leeway_ratio := 0.25

onready var time_between_beats : float = 60.0 / beats_per_minute

onready var pronounced_sound : AudioStreamPlayer = $PronouncedSound
onready var regular_sound : AudioStreamPlayer = $RegularSound
onready var animation_player : AnimationPlayer = $BeatDisplay/AnimationPlayer

var nth_beat : int = -1
var beat_delta : float = 0.0


func _ready() -> void:
	$BeatDisplay.material.set_shader_param("base_color",
			Settings.get_color_from_key("beats"))


func _process(delta: float) -> void:
	if not enabled:
		return
	
	beat_delta += delta
	
	if beat_delta < time_between_beats:
		return
	
	nth_beat = (nth_beat + 1) % time_signature
	
	_beat(nth_beat)
	
	beat_delta -= time_between_beats


func _beat(count: int) -> void:
	if count == 0 and pronounced_beats:
		pronounced_sound.play()
		animation_player.play("pronounced")
	else:
		regular_sound.play()
		animation_player.play("regular")
	
	emit_signal("beat")


func set_enabled(value: bool) -> void:
	if not value and enabled:
		nth_beat = -1
		beat_delta = 0.0
	
	enabled = value


func set_beats_per_minute(bpm: int) -> void:
	beats_per_minute = bpm
	time_between_beats = 60.0 / beats_per_minute


func is_closest_beat_pronounced() -> bool:
	var offset : int = 1 if beat_delta > (time_between_beats*0.5) else 0
	var closest_beat : int = (nth_beat + offset) % time_signature
	return closest_beat == 0


func is_on_beat() -> bool:
	return is_within_previous_beat() or is_within_next_beat()


func is_within_next_beat() -> bool:
	var leeway : float = time_between_beats * leeway_ratio
	return (time_between_beats - beat_delta) <= leeway


func is_within_previous_beat() -> bool:
	var leeway : float = time_between_beats * leeway_ratio
	return beat_delta <= leeway
