extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var player = get_tree().root.find_node("Player", true, false)
	if player:
		player.get_parent().call_deferred("remove_child", player)

	get_tree().root.find_node("Music", true, false).stop()
	get_tree().root.find_node("Healthbar", true, false).visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
