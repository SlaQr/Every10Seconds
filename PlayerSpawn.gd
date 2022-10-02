extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player: KinematicBody2D
var player_collision: CollisionShape2D
var _player_pull = true

# Called when the node enters the scene tree for the first time.
func _ready():

	player = get_tree().root.find_node("Player", true, false)
	player_collision = player.get_node("CollisionShape2D")
	player_collision.disabled = true

	get_node("DisableTimer").play("DisablePlayerPull")

func _process(_delta):
	if _player_pull:
		player.position = (player.position * 0.95) + \
						  (position * 0.05)

func disable_player_pull():
	player_collision.disabled = false
	_player_pull = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
