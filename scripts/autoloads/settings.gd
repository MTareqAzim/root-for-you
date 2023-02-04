extends Node

enum Layout {CORNER, TRIGGER, FACE}
enum Volume {MASTER, BEATS, CROWD, CHARACTERS}

var layout : int = Layout.TRIGGER
var palette : int = 0
var volume : Array = [100, 100, 100, 100]
