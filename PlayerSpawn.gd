extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player: KinematicBody2D
var player_collision: CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():

	player = get_tree().root.find_node("Player", true, false)
	player_collision = player.get_node("CollisionShape2D")

func _process(_delta):
	if not player.can_move:
		player.position = (player.position * 0.95) + \
						  (position * 0.05)