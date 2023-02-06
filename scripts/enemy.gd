extends Control

signal cheer(cheer_record)
signal fight_animation_ended
signal new_beat(bpm, pronounced)
signal max_beats(max_beats)
signal enemy_cheers(cheers)
signal done
signal enemy_ready
signal end_game(win)

onready var sprite : TextureRect = $Sprite
onready var animation_player : AnimationPlayer = $AnimationPlayer

const key = "villain"

var cheers : Array = [
	["attack", "attack", "block", "attack"],
	["attack", "beat", "block", "beat", "attack", "magic", "beat", "magic"],
	["attack", "beat", "open", "block", "magic", "beat", "attack", "attack"],
	["open", "attack", "block", "block", "magic", "attack", "magic", "attack", "magic", "open"],
	["attack", "block", "attack", "open", "magic", "magic", "magic", "block", "block", "magic", "open", "open", "attack"]
]
var beats : Array = [60, 70, 80, 80, 100]
var level : int = 0
var done : bool = false
var enabled : bool = false

func _ready() -> void:
	sprite.material.set_shader_param("base_color", Settings.get_color_from_key("villain"))


func start() -> void:
	animation_player.play("fade_in", -1, 0.2)
	animation_player.queue("laughing")


func start_level(time_before_starting: float) -> void:
	if level >= cheers.size():
		animation_player.play("death")
		return
	
	emit_signal("new_beat", beats[level], false)
	emit_signal("max_beats", cheers[level].size())
	emit_signal("enemy_cheers", cheers[level])
	
	yield(get_tree().create_timer(time_before_starting), "timeout")
	done = false


func play_animation(animation: String) -> void:
	animation_player.play(animation)


func _on_beat() -> void:
	if not enabled:
		return
	
	if done:
		animation_player.play("jump")
		return
	
	if cheers[level].empty():
		emit_signal("done")
		done = true
		level += 1
		return
	
	var cheer_record = CheerRecord.new()
	cheer_record.cheer = cheers[level].pop_front()
	animation_player.play("cheer_%s" % [cheer_record.cheer])
	emit_signal("cheer", cheer_record)


func _on_animation_finished(anim_name):
	if anim_name in []:
		emit_signal("fight_animation_ended")
