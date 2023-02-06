extends Control

export var time_between_levels : float = 3.0

onready var beat_keeper = $BeatKeeper
onready var cheer_recorder = $CheerRecorder
onready var enemy_pattern_displayer = $EnemyPattern
onready var crowd_pattern_displayer = $CrowdPattern
onready var layout = $LayoutManager
onready var enemy = $Enemy
onready var player = $Player
onready var animation_player = $AnimationPlayer
onready var fight_manager = $FightManager
onready var bpm_label = $BPMLabel

enum Outcomes {PLAYER, ENEMY}

var just_started : bool = true


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
	bpm_label.set_bpm_text(bpm)
	bpm_label.play_bpm_animation()
	
	if just_started:
		enemy.enabled = true
		beat_keeper.show()
		beat_keeper.modulate = Color.transparent
		animation_player.play("enemy_pattern_displayer_fade_in")
		animation_player.queue("beat_fade_in")


func show_enemy_pattern() -> void:
	enemy_pattern_displayer.show()


func set_max_beats(max_beats: int) -> void:
	cheer_recorder.max_beats = max_beats


func set_enemy_cheers(cheers: Array) -> void:
	fight_manager.set_enemy_cheers(cheers)


func enemy_ready() -> void:
	enemy.start_level(time_between_levels)


func enemy_done() -> void:
	if just_started:
		first_completion()
		just_started = false
	else:
		animation_player.play("crowd_pattern_displayer_fade_in")


func first_completion() -> void:
	layout.modulate = Color.transparent
	layout.show()
	player.show()
	animation_player.queue("player_fade_in")
	animation_player.queue("layout_fade_in")
	yield(get_tree().create_timer(1.5), "timeout")
	layout.enabled = true
	crowd_pattern_displayer.show()
	animation_player.play("crowd_pattern_displayer_fade_in")


func recording_done():
	fight_manager.set_crowd_cheers(cheer_recorder.get_recording())
	cheer_recorder.reset_recording()
	yield(get_tree().create_timer(1.0), "timeout")
	player.enabled = false
	enemy.enabled = false
	fight_manager.start_fight()


func play_outcome(outcome : Array) -> void:
	#fight_manager.enabled = false
	player.play_animation(outcome[Outcomes.PLAYER])
	enemy.play_animation(outcome[Outcomes.ENEMY])
	enemy_pattern_displayer.clear_first_cheer()
	crowd_pattern_displayer.clear_first_cheer()


func fighting_done():
	enemy.enabled = true
	player.enabled = true
	animation_player.play("crowd_pattern_displayer_fade_out")
	yield(get_tree().create_timer(2.0), "timeout")
	enemy.start_level(time_between_levels)


func fight_animation_ended() -> void:
	if not player.is_playing_animation() and not enemy.is_playing_animation():
		fight_manager.enabled = true


func end_game(win: bool) -> void:
	if win:
		pass
		#win
	else:
		pass
		#lose
