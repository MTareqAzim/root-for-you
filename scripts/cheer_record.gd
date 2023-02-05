extends Resource
class_name CheerRecord

var cheer : String = "beat"
var is_pronounced : bool = false


func _to_string() -> String:
	var pronounced = "pronounced" if is_pronounced else "regular"
	return "%s, %s" % [cheer.to_upper(), pronounced]
