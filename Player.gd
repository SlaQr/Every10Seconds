extends KinematicBody2D

onready var bullet = preload("res://Bullet.tscn")

onready var anim = get_node("Animations/Movement")

onready var attack_anim = get_node("Animations/Attacks")

var can_move = true
var player_speed = 300

func _compare_input(s1, s2):
	return int(Input.is_action_pressed(s1)) - \
		   int(Input.is_action_pressed(s2))

func _player_movement():

	var input = Vector2(
		_compare_input("plr_right", "plr_left"),
		_compare_input("plr_down", "plr_up")
	)
	
	var _returned = move_and_slide(input.normalized() * player_speed)

	if input.x == 0 && input.y == 0:
		anim.play("Idle")
		return
	
	get_node("Animations").scale.x = abs(get_node("Animations").scale.x)
	#scale.x = 1
	if abs(input.x) >= abs(input.y):
		anim.play("WalkSide")
		if input.x < 0:
			#anim.flip_h = true
			get_node("Animations").scale.x = -abs(get_node("Animations").scale.x)
		return

	if input.y > 0:
		anim.play("WalkForward")
	else:
		anim.play("WalkBackward")

# Called when the node enters the scene tree for the first time.

###################################
########## GODOT METHODS ##########
###################################

func _physics_process(_delta):
	if can_move:
		_player_movement()