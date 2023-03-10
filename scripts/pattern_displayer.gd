extends NinePatchRect

const TEXTURE_SIZE := Vector2(24, 24)
const CHEER_RESOURCE = preload("res://scenes/ui_scenes/cheer_icon.tscn")

var texture_paths = {
	"start":"res://assets/art/icons/start.png",
	"beat":"res://assets/art/icons/beat.png",
	"attack":"res://assets/art/icons/placeholder.png",
	"block":"res://assets/art/icons/placeholder.png",
	"heal":"res://assets/art/icons/placeholder.png",
	"magic":"res://assets/art/icons/placeholder.png",
	"open":"res://assets/art/icons/placeholder.png"
}

export(String) var character : String = "crowd"
var image_textures : Dictionary
var just_started : bool = false

onready var vfc : VFlowContainer = $VFC
onready var outline : NinePatchRect = $Outline


func _ready() -> void:
	call_deferred("reset_pattern")
	_load_image_textures()
	outline.material.set_shader_param("base_color", Settings.get_color_from_key(character))


func display_cheer(cheer_record: CheerRecord) -> void:
	if just_started:
		var start = vfc.get_child(0)
		vfc.remove_child(start)
		start.queue_free()
		just_started = false
	
	var cheer_icon : Control = CHEER_RESOURCE.instance()
	cheer_icon.texture = image_textures[cheer_record.cheer]
	if character == "villain":
		cheer_icon.cheer = _to_player_cheer(cheer_record.cheer)
	else:
		cheer_icon.cheer = cheer_record.cheer
	cheer_icon.rect_min_size = TEXTURE_SIZE
	cheer_icon.is_pronounced = cheer_record.is_pronounced
	
	vfc.add_child(cheer_icon)


func overwrite_prev_beat() -> void:
	if vfc.get_child_count() > 0:
		var to_free = vfc.get_children().back()
		if to_free.cheer == "beat":
			vfc.remove_child(to_free)
			to_free.queue_free()


func reset_pattern() -> void:
	for child in vfc.get_children():
		vfc.remove_child(child)
		child.queue_free()
	vfc.set_size(Vector2.ZERO, true)
	vfc.set_anchors_preset(Control.PRESET_CENTER, true)
	
	_add_start_icon()


func clear_first_cheer() -> void:
	if vfc.get_child_count() <= 0:
		return
	var to_free = vfc.get_child(0)
	vfc.remove_child(to_free)
	to_free.queue_free()
	vfc.set_anchors_preset(Control.PRESET_CENTER, true)
	
	if vfc.get_child_count() != 0:
		return
	
	_add_start_icon()


func _add_start_icon() -> void:
	var start_icon : Control = CHEER_RESOURCE.instance()
	start_icon.texture = image_textures["start"]
	start_icon.cheer = "beat"
	start_icon.rect_min_size = TEXTURE_SIZE
	start_icon.is_pronounced = false
	vfc.add_child(start_icon)
	just_started = true


func _to_player_cheer(cheer: String) -> String:
	match cheer:
		"beat", "open":
			return cheer
		"attack":
			return "block"
		"block":
			return "magic"
		"magic":
			return "attack"
		"heal":
			return "open"
		_:
			return cheer


func _set_rect_size() -> void:
	var prev_rect_size = rect_size
	rect_size = vfc.rect_size
	rect_position = rect_position - rect_size/2.0 + prev_rect_size/2.0
	outline.rect_size = rect_size + Vector2(2, 2)
	outline.rect_position = Vector2(-1, -1)


func _load_image_textures() -> void:
	for key in texture_paths:
		var image_texture = load(texture_paths[key])
		image_textures[key] = image_texture


func _on_VFC_resized():
	call_deferred("_set_rect_size")
