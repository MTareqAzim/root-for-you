tool
extends TextureRect

signal clicked(input_action)

export(String) var action

onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready():
	set_shader_color(Settings.get_color_from_key(action))


func _input(event) -> void:
	if event.is_action_pressed(action):
		_clicked()


func set_shader_color(color: Color) -> void:
	material.set_shader_param("base_color", color)


func _clicked() -> void:
	animation_player.play("clicked")
	get_viewport().set_input_as_handled()
	emit_signal("clicked", action)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "RESET":
		return
	
	animation_player.play("RESET")
