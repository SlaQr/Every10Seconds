extends NavigationAgent2D


var _player: KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_tree().get_root().find_node("Player", true, false)
	set_target_location(_player.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	set_target_location(_player.position)
	var next_location = get_next_location()
	get_parent().next_location = next_location

