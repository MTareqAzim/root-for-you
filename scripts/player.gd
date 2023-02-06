extends Control

signal fight_animation_ended

onready var sprite : TextureRect = $Sprite
onready var animation_player : AnimationPlayer = $AnimationPlayer
var enabled : bool = false

func _ready():
	sprite.material.set_shader_param("base_color",
			Settings.get_color_from_key("player"))


func is_playing_animation() -> bool:
	return animation_player.is_playing()


func play_animation(animation: String) -> void:
	animation_player.play(animation)


func _on_beat() -> void:
	if not enabled:
		return
	
	animation_player.play("jump")



func _on_animation_finished(anim_name):
	if anim_name in []:
		emit_signal("fight_animation_ended")
