extends Node

signal cheer_recorded(cheer_record)
signal prev_beat_overwritten
signal off_beat
signal end_recording

export(NodePath) var beat_keeper_path
export(int) var max_beats = 10

onready var beat_keeper = get_node(beat_keeper_path)
onready var total_beats = 0
onready var cheers : Array = []

var _is_recording : bool = false
var _is_recording_cheers : bool = false
var _skip_next_beat :bool = false


func start_recording() -> void:
	reset_recording()
	_is_recording = true


func stop_recording() -> void:
	_is_recording = false
	_is_recording_cheers = false


func reset_recording() -> void:
	total_beats = 0
	cheers.clear()


func get_recording() -> Array:
	return cheers


func _on_cheer(cheer: String) -> void:
	if not _is_recording:
		return
	
	if not beat_keeper.is_on_beat():
		emit_signal("off_beat")
		return
	
	var cheer_record = CheerRecord.new()
	cheer_record.cheer = cheer
	cheer_record.is_pronounced = beat_keeper.is_closest_beat_pronounced()
	
	if cheers.empty():
		_is_recording_cheers = true
	
	if beat_keeper.is_within_next_beat():
		_skip_next_beat = true
	
	if beat_keeper.is_within_previous_beat():
		if cheers.size() > 0:
			if cheers.back().cheer == "beat":
				cheers.pop_back()
				emit_signal("prev_beat_overwritten")
	
	emit_signal("cheer_recorded", cheer_record)
	cheers.append(cheer_record)


func _on_beat() -> void:
	if not _is_recording_cheers:
		return
	
	total_beats += 1
	
	if total_beats > max_beats:
		emit_signal("end_recording")
		stop_recording()
		return
	
	if not _skip_next_beat:
		var beat_record = CheerRecord.new()
		emit_signal("cheer_recorded", beat_record)
		cheers.append(beat_record)
	
	_skip_next_beat = false

