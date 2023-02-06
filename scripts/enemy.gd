extends Control

signal cheer(cheer_record)

onready var sprite : TextureRect = $Sprite
onready var animation_player : AnimationPlayer = $AnimationPlayer

const key = "villain"

var cheers : Array = ["attack", "beat", "attack", "beat", "block", "beat", "attack"]
var done : bool = false

func _ready() -> void:
	sprite.material.set_shader_param("base_color", Settings.get_color_from_key("villain"))


func start() -> void:
	animation_player.play("fade_in", -1, 0.2)
	animation_player.queue("laughing")


func start_level() -> void:
	get_parent().set_beat(60, false, 3.0)
	get_parent().set_max_beats(cheers.size())


func _on_beat() -> void:
	animation_player.play("jump")
	
	if done:
		return
	
	if cheers.empty():
		get_parent().enemy_done()
		done = true
		return
	
	var cheer_record = CheerRecord.new()
	cheer_record.cheer = cheers.pop_front()
	emit_signal("cheer", cheer_record)
