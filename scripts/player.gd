extends Control

onready var sprite : TextureRect = $Sprite
onready var animation_player : AnimationPlayer = $AnimationPlayer
var enabled : bool = false

func _ready():
	sprite.material.set_shader_param("base_color",
			Settings.get_color_from_key("player"))


func _on_beat():
	if not enabled:
		return
	
	animation_player.play("jump")
