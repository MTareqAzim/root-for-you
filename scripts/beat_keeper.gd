extends Control

export(float) var beats_per_minute := 1.0
export(bool) var pronounced_beats := false
export(int, 1, 100) var time_signature := 4

onready var time_between_beats : float = 1.0 / beats_per_minute

onready var pronounced_sound : AudioStreamPlayer = $PronouncedSound
onready var regular_sound : AudioStreamPlayer = $RegularSound
onready var beat_display : AnimatedSprite = $Control/BeatDisplay

var nth_beat : int = 0
var beat_delta : float = 0.0


func _process(delta: float) -> void:
	beat_delta += delta
	
	if beat_delta < time_between_beats:
		return
	
	nth_beat = (nth_beat + 1) % time_signature
	
	_beat(nth_beat)
	
	beat_delta -= time_between_beats


func _beat(count: int) -> void:
	if count == 0 and pronounced_beats:
		pronounced_sound.play()
		beat_display.play("pronounced")
	else:
		regular_sound.play()
		beat_display.play("regular")

