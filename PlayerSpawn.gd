extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var _player_pull = true

# Called when the node enters the scene tree for the first time.
func _ready():

	get_node("../Player/CollisionShape2D").disabled = true
	get_node("DisableTimer").play("DisablePlayerPull")

func _process(_delta):
	if _player_pull:
		var player = get_node("../Player")
		player.position = (player.position * 0.95) + \
						  (position * 0.05)

func disable_player_pull():
	get_node("../Player/CollisionShape2D").disabled = false
	_player_pull = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass