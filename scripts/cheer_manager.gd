extends Control

signal cheered(action)


func _on_Heal_clicked(input_action):
	emit_signal("cheered", input_action)


func _on_Block_clicked(input_action):
	emit_signal("cheered", input_action)


func _on_Attack_clicked(input_action):
	emit_signal("cheered", input_action)


func _on_Magic_clicked(input_action):
	emit_signal("cheered", input_action)
