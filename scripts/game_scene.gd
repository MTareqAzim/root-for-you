extends Control

onready var beat_keeper = $BeatKeeper
onready var timer : Timer = $Timer


func _ready():
	beat_keeper.enabled = false
	timer.start(3)


func _on_Timer_timeout():
	beat_keeper.enabled = true
