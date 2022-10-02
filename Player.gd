extends KinematicBody2D

onready var bullet = preload("res://Bullet.tscn")

onready var anim = get_node("Animations/Movement")

var player_speed = 300

var can_attack = true;

func _compare_input(s1, s2):
	return int(Input.is_action_pressed(s1)) - \
		   int(Input.is_action_pressed(s2))

func _check_attack():
	return Input.is_action_pressed("plr_fire") and can_attack

func _attack():

	# get fire direction
	var mouse_position = get_viewport().get_mouse_position()
	var test = mouse_position - position

	# get gun type
	# TODO
	var bullet_instance = bullet.instance()

	# fire bullet(s)
	
	bullet_instance.position = position
	get_tree().root.add_child(bullet_instance)
	bullet_instance.set_direction(test.normalized())

	# start cooldown
	can_attack = false;
	get_node("Timers").play("GunReload")

func _player_movement():

	var input = Vector2(
		_compare_input("plr_right", "plr_left"),
		_compare_input("plr_down", "plr_up")
	)
	
	var _returned = move_and_slide(input.normalized() * player_speed)

	if input.x == 0 && input.y == 0:
		anim.play("Idle")
		return
	
	anim.flip_h = false
	if abs(input.x) >= abs(input.y):
		anim.play("WalkSide")
		if input.x < 0:
			anim.flip_h = true
		return

	if input.y > 0:
		anim.play("WalkForward")
	else:
		anim.play("WalkBackward")
	

	

# Called when the node enters the scene tree for the first time.

###################################
########## GODOT METHODS ##########
###################################

func _ready():
	pass

func _process(_delta):
	if _check_attack():
		_attack()

func _physics_process(_delta):
	_player_movement()

###################################
######### EXTERNAL SIGNALS ########
###################################

func reset_attack():
	can_attack = true
