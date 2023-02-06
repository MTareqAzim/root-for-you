extends Control

signal fight_over()
signal outcome(outcome)

var enemy_cheers : Array
var crowd_cheers : Array

var fight : bool = false
var enabled : bool = false

enum Outcomes {PLAYER, ENEMY}

const outcomes : Dictionary = {
	"beat" : {
		"beat" : ["jump", "jump"],
		"attack" : ["hurt_countered_attack_attack", "attack"],
		"block" : ["hurt_countered_block_magic", "magic"],
		"magic" : ["hurt_countered_magic_attack", "attack"],
		"heal" : ["hurt_countered_heal_attack", "attack"]
	},
	"attack" : {
		"beat" : ["hurt_attack", "attack"],
		"attack" : ["hurt_countered_attack_attack", "attack"],
		"block" : ["block_counter", "hurt_countered_attack_block"],
		"magic" : ["hurt_countered_magic", "attack"],
		"heal" : ["hurt_countered_heal", "attack"]
	},
	"block" : {
		"beat" : ["jump", "block"],
		"attack" : ["hurt_countered_attack_block", "block_counter"],
		"block" : ["block", "block"],
		"magic" : ["magic", "hurt_countered_block_magic"],
		"heal" : ["heal", "block"]
	},
	"magic" : {
		"beat" : ["hurt_magic", "magic"],
		"attack" : ["attack", "hurt_countered_magic_attack"],
		"block" : ["hurt_countered_block", "magic"],
		"magic" : ["hurt_countered_magic_magic", "magic"],
		"heal" : ["hurt_countered_heal_magic", "magic"]
	},
	"open" : {
		"beat" : ["jump", "jump"],
		"attack" : ["attack", "hurt_attack"],
		"block" : ["block", "jump"],
		"magic" : ["magic", "hurt_magic"],
		"heal" : ["heal", "jump"]
	}
}


func set_enemy_cheers(cheers: Array) -> void:
	enemy_cheers = cheers.duplicate()


func set_crowd_cheers(cheers: Array) -> void:
	crowd_cheers = cheers.duplicate()


func start_fight() -> void:
	fight = true
	enabled = true


func _on_beat() -> void:
	if not fight or not enabled:
		return
	
	if enemy_cheers.empty():
		emit_signal("fight_over")
		fight = false
		return
	
	var outcome = _fight(crowd_cheers.pop_front().cheer, enemy_cheers.pop_front())
	emit_signal("outcome", outcome)


func _fight(crowd: String, enemy: String) -> Array:
	var enemy_responses = outcomes[enemy]
	return enemy_responses[crowd]
