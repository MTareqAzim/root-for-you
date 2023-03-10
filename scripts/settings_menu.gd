extends Control

export(String, FILE, "*.tscn") var main_menu

enum Options {LAYOUT, PALETTES, MASTER, BEATS, CROWD, CHARACTERS, EXIT}
enum Layout {CORNERS, TRIGGERS, FACE}

var current_option : int = Options.LAYOUT

onready var palette_preview = $VBoxContainer/PalettePreview

onready var layout_bgs : Array = [
	$VBoxContainer/ButtonLayoutOptions/Corners/BG,
	$VBoxContainer/ButtonLayoutOptions/Triggers/BG,
	$VBoxContainer/ButtonLayoutOptions/Face/BG
]

onready var palette_bg : ColorRect = $VBoxContainer/PalettePreview/BG
onready var exit_bg : ColorRect = $VBoxContainer/Exit/BG

onready var sounds_bg : Array = [
	$VBoxContainer/Master/Volume,
	$VBoxContainer/Beats/Volume,
	$VBoxContainer/Crowd/Volume,
	$VBoxContainer/Characters/Volume
]

onready var sounds_demo : Array = [
	$Master,
	$Beats,
	$Crowd,
	$Characters
]

const hover_color : Color = Color("648a8a00")
const selected_color : Color = Color("f08f0000")
const base_color : Color = Color("64000000")


func _ready() -> void:
	_set_bgs()
	if get_viewport().has_method("preload_scene"):
		get_viewport().call_deferred("preload_scene", main_menu)


func _input(event) -> void:
	var vertical : int= int(event.is_action_pressed("ui_down")) - int(event.is_action_pressed("ui_up"))
	
	if not vertical == 0:
		_unhighlight()
		current_option += vertical
		current_option = int(clamp(current_option, 0, Options.size() - 1))
		_highlight()
		get_viewport().set_input_as_handled()
		return
	
	var horizontal = int(event.is_action_pressed("ui_right")) - int(event.is_action_pressed("ui_left"))
	
	if not horizontal == 0:
		match current_option:
			Options.LAYOUT:
				layout_bgs[Settings.layout].color = base_color
				Settings.layout = posmod((Settings.layout + horizontal), Settings.Layout.size())
				layout_bgs[Settings.layout].color = hover_color
			Options.PALETTES:
				Settings.palette = posmod(Settings.palette + horizontal, Settings.palettes.size())
				palette_preview.refresh_preview()
			Options.MASTER, Options.BEATS, Options.CROWD, Options.CHARACTERS:
				var index = current_option - 2
				Settings.volume[index] += horizontal * 5
				var play_test : bool = Settings.volume[index] <= 100
				Settings.volume[index] = int(clamp(Settings.volume[index], 0, 100))
				var linear_vol = float(Settings.volume[index]) / 100.0
				sounds_bg[index].anchor_right = linear_vol
				
				if play_test:
					AudioServer.set_bus_volume_db(index, linear2db(linear_vol))
					sounds_demo[index].play()
		get_viewport().set_input_as_handled()
		return
	
	if event.is_action_pressed("ui_accept"):
		if current_option == Options.EXIT:
			get_viewport().call_deferred("change_to_preloaded_scene")
			get_viewport().set_input_as_handled()


func _set_bgs() -> void:
	for index in layout_bgs.size():
		if index == Settings.layout:
			layout_bgs[index].color = selected_color
		else:
			layout_bgs[index].color = base_color
	
	palette_bg.color = base_color
	exit_bg.color = base_color
	
	for index in sounds_bg.size():
		sounds_bg[index].color = base_color
		sounds_bg[index].anchor_right = Settings.volume[index] / 100.0
	
	_highlight()


func _highlight() -> void:
	match current_option:
		Options.LAYOUT:
			layout_bgs[Settings.layout].color = hover_color
		Options.PALETTES:
			palette_bg.color = hover_color
		Options.MASTER, Options.BEATS, Options.CROWD, Options.CHARACTERS:
			sounds_bg[current_option - 2].color = hover_color
		Options.EXIT:
			exit_bg.color = hover_color


func _unhighlight() -> void:
	match current_option:
		Options.LAYOUT:
			layout_bgs[Settings.layout].color = selected_color
		Options.PALETTES:
			palette_bg.color = base_color
		Options.MASTER, Options.BEATS, Options.CROWD, Options.CHARACTERS:
			sounds_bg[current_option - 2].color = base_color
		Options.EXIT:
			exit_bg.color = base_color
