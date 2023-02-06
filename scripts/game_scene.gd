extends Control

onready var beat_keeper = $BeatKeeper
onready var cheer_recorder = $CheerRecorder
onready var enemy_pattern_displayer = $EnemyPattern
onready var crowd_pattern_displayer = $CrowdPattern
onready var layout = $LayoutManager
onready var enemy = $Enemy
onready var player = $Player
onready var animation_player = $AnimationPlayer


func _ready():
	enemy_pattern_displayer.hide()
	crowd_pattern_displayer.hide()
	beat_keeper.enabled = false
	beat_keeper.hide()
	beat_keeper.modulate = Color.transparent
	player.hide()
	layout.enabled = false
	layout.hide()
	
	enemy.call_deferred("start")


func set_beat(bpm: int, pronounced: bool = false, delay: float = 0.0) -> void:
	beat_keeper.set_beats_per_minute(bpm)
	beat_keeper.pronounced_beats = pronounced
	beat_keeper.show()
	
	animation_player.play("beat_fade_in")
	yield(get_tree().create_timer(delay), "timeout")
	beat_keeper.enabled = true
	show_enemy_pattern()


func show_enemy_pattern() -> void:
	enemy_pattern_displayer.show()


func set_max_beats(max_beats: int) -> void:
	cheer_recorder.max_beats = max_beats


func enemy_done():
	layout.modulate = Color.transparent
	layout.show()
	player.show()
	animation_player.queue("player_fade_in")
	animation_player.queue("layout_fade_in")
	yield(get_tree().create_timer(1.5), "timeout")
	layout.enabled = true
	crowd_pattern_displayer.show()
	cheer_recorder.start_recording()


func _on_end_recording():
	pass
