extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_speed = 200

func _compare_input(s1, s2):
	return int(Input.is_action_pressed(s1)) - int(Input.is_action_pressed(s2))

func player_movement():

	var input = Vector2(
		_compare_input("plr_right", "plr_left"),
		_compare_input("plr_down", "plr_up")
	).normalized() * player_speed

	var _returned = move_and_slide(input)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	var _a = delta + 1
	player_movement()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
