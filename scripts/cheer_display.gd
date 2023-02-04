tool
extends TextureRect

signal clicked(input_action)

export(Color) var color = Color.white setget set_color
export(String) var action

onready var animation_player : AnimationPlayer = $AnimationPlayer


func _input(event) -> void:
	if event.is_action_pressed(action):
		_clicked()


func set_color(new_color: Color) -> void:
	color = new_color
	material.set_shader_param("base_color", color)


func _clicked() -> void:
	animation_player.play("clicked")
	get_viewport().set_input_as_handled()
	emit_signal("clicked", action)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "RESET":
		return
	
	animation_player.play("RESET")
