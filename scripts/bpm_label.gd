extends Label

onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	hide()
	material.set_shader_param("base_color", Settings.get_color_from_key("beat"))


func play_bpm_animation() -> void:
	animation_player.play("jump_in")


func set_bpm_text(bpm: int) -> void:
	text = "BPM: %d" % [bpm]
