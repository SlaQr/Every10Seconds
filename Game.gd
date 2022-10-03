extends Node2D

onready var level_switcher = get_node("LevelSwitcher")
onready var cloud_transition = get_node("CloudTransition")

var current_level_node

func _ready():
	Global.connect("next_level", self, "anim_level_out")

func unload_current_level():
	if current_level_node:
		remove_child(current_level_node)

func load_next_level():
	current_level_node = Global.next_level.instance()
	add_child(current_level_node)

func cloud_in():
	cloud_transition.play("CloudIn")

func cloud_out():
	cloud_transition.play("CloudOut")

func anim_level_in():
	level_switcher.play("LevelIn")

func anim_level_out():
	level_switcher.play("LevelOut")

func change_levels():
	Global.emit_signal("next_level")
