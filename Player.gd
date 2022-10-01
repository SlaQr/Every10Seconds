extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var bullet = preload("res://Bullet.tscn")

var player_speed = 200

var can_attack = true;

func _compare_input(s1, s2):
	return int(Input.is_action_pressed(s1)) - \
		   int(Input.is_action_pressed(s2))

func _check_attack():
	return Input.is_action_pressed("plr_fire") and can_attack

func _attack():

	# get fire direction
	var mouse_position = get_viewport().get_mouse_position()

	var bullet_instance = bullet.instance()

	bullet_instance.position = position

	get_tree().root.add_child(bullet_instance)

	var test = mouse_position - position

	bullet_instance.set_direction(test.normalized())

	#get_tree.get_root().add_child(bullet_instance)
	# get gun type

	# fire bullet(s)

	# start cooldown
	can_attack = false;
	get_node("Timers").play("GunReload")
	print("fired")

func _player_movement():

	var input = Vector2(
		_compare_input("plr_right", "plr_left"),
		_compare_input("plr_down", "plr_up")
	).normalized() * player_speed

	var _returned = move_and_slide(input)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):

	if _check_attack():
		_attack()

	var _a = delta + 1

func _physics_process(delta):
	var _a = delta + 1
	_player_movement()

###################################
######## EXTERNAL SIGNALS #########
###################################

func reset_attack():
	print("reloaded")
	can_attack = true