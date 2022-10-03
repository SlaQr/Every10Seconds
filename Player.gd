extends KinematicBody2D

onready var bullet = preload("res://Bullet.tscn")

onready var anim = get_node("Animations/Movement")
onready var ground_crack = get_node("Animations/GroundCrack")
onready var ground_slam = get_node("Animations/GroundSlam")
onready var attack_anim = get_node("Animations/Attacks")

var can_move = false
var player_speed = 300

func player_slam():

	can_move = false
	anim.visible = false

	ground_slam.visible = true
	ground_slam.frame = 0
	ground_slam.play("Slam")

func enable_player_input():
	can_move = true
	anim.visible = true
	ground_slam.visible = false
	ground_crack.visible = false

func crack_ground():
	ground_crack.frame = 0
	ground_crack.visible = true
	ground_crack.play("Crack")

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

###################################
########## GODOT METHODS ##########
###################################

func _physics_process(_delta):
	if can_move:
		_player_movement()