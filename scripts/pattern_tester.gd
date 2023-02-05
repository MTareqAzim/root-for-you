extends CenterContainer

onready var pattern_displayer = $BG

var cheers = ["beat", "attack", "block", "heal", "magic", "open"]
var beat = -1


func _ready():
	cheer()
	randomize()


func cheer():
	yield(get_tree().create_timer(1.0), "timeout")
	if bool(randi() % 3):
		_cheer()
	else:
		_rewrite_beat()


func _cheer():
	var cheer = CheerRecord.new()
	cheer.cheer = cheers[randi()%cheers.size()]
	beat += 1
	cheer.is_pronounced = not bool(beat%4)
	pattern_displayer.display_cheer(cheer)
	
	cheer()


func _rewrite_beat():
	var cheer = CheerRecord.new()
	beat += 1
	cheer.is_pronounced = not bool(beat%4)
	pattern_displayer.display_cheer(cheer)
	
	yield(get_tree().create_timer(0.2), "timeout")
	
	pattern_displayer.overwrite_prev_beat()
	cheer.cheer = cheers[randi()%cheers.size()]
	pattern_displayer.display_cheer(cheer)
	
	cheer()
