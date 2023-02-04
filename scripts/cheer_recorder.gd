extends Node

export(NodePath) var beat_keeper_path
export(int) var max_beats = 10

onready var beat_keeper = get_node(beat_keeper_path)
onready var total_beats = 0
onready var cheers : Array = []

var _is_recording : bool = false
var _is_recording_cheers : bool = false
var _beats_since_last_cheer : int = 0


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
	
	var cheer_record = CheerRecord.new()
	cheer_record.cheer = cheer
	cheer_record.is_pronounced = beat_keeper.is_closest_beat_pronounced()
	cheer_record.is_on_beat = beat_keeper.is_on_beat()
	cheer_record.beats_since_last_cheer = _beats_since_last_cheer + int(beat_keeper.is_within_next_beat())
	cheer_record.time_between_beats = beat_keeper.time_between_beats
	
	if cheers.empty():
		_is_recording_cheers = true
	
	_beats_since_last_cheer -= cheer_record.beats_since_last_cheer
	
	cheers.append(cheer_record)


func _on_beat() -> void:
	if not _is_recording_cheers:
		return
	
	total_beats += 1
	_beats_since_last_cheer += 1
	
	if total_beats > max_beats:
		stop_recording()


class CheerRecord:
	var cheer : String
	var is_pronounced : bool
	var is_on_beat : bool
	var beats_since_last_cheer : int
	var time_between_beats : float
	
	func _to_string() -> String:
		var pronounced = "pronounced" if is_pronounced else "regular"
		var on_beat = "on_beat" if is_on_beat else "off_beat"
		return "%s, %s, %s, %i beats since last cheer, %.2f seconds between beats." % \
				[cheer.to_upper(), pronounced, on_beat, beats_since_last_cheer, time_between_beats]
