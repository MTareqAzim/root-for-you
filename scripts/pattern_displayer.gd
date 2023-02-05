extends NinePatchRect

const TEXTURE_SIZE := Vector2(24, 24)
const CHEER_RESOURCE = preload("res://scenes/ui_scenes/cheer_icon.tscn")

export(Dictionary) var texture_paths = {
	"beat":"res://assets/art/icons/beat.png",
	"attack":"res://assets/art/icons/placeholder.png",
	"block":"res://assets/art/icons/placeholder.png",
	"heal":"res://assets/art/icons/placeholder.png",
	"magic":"res://assets/art/icons/placeholder.png",
	"open":"res://assets/art/icons/placeholder.png"
}

var image_textures : Dictionary

onready var vfc : VFlowContainer = $VFC


func _ready() -> void:
	call_deferred("_set_rect_size")
	_load_image_textures()


func display_cheer(cheer: CheerRecord) -> void:
	var cheer_icon : TextureRect = CHEER_RESOURCE.instance()
	cheer_icon.texture = image_textures[cheer.cheer]
	cheer_icon.cheer = cheer.cheer
	cheer_icon.rect_min_size = TEXTURE_SIZE
	cheer_icon.is_pronounced = cheer.is_pronounced
	
	vfc.add_child(cheer_icon)


func overwrite_prev_beat() -> void:
	if vfc.get_child_count() > 0:
		var to_free = vfc.get_children().back()
		if to_free.cheer == "beat":
			vfc.remove_child(to_free)
			to_free.queue_free()


func _set_rect_size() -> void:
	var prev_rect_size = rect_size
	rect_size = vfc.rect_size
	rect_position = rect_position - rect_size/2.0 + prev_rect_size/2.0


func _load_image_textures() -> void:
	for key in texture_paths:
		var image_texture = load(texture_paths[key])
		image_textures[key] = image_texture


func _on_VFC_resized():
	call_deferred("_set_rect_size")
