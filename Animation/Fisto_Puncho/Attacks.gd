extends AnimatedSprite

onready var player = get_parent().get_parent()
onready var punchH_hitbox = get_node("../PunchH_Hitbox")
onready var movement_anim = get_node("../Movement")

var last_h_punch = "PunchB"
var can_attack = true;
var can_punch = true;

var previously_punched = {}

var punch_force = 1000

func punchH():
	if last_h_punch == "PunchB":
		last_h_punch = "PunchF"
		z_index = 3
	else:
		last_h_punch = "PunchB"
		z_index = 1

	punchH_hitbox.monitoring = true
	frame = 0
	visible = true
	can_punch = false
	play(last_h_punch)

func _check_punch():
	return Input.is_action_pressed("plr_fire") and can_punch

func allow_punch():
	punchH_hitbox.monitoring = false
	visible = false
	can_punch = true

func _punch():

	previously_punched.clear()
	# get fire direction
	#var mouse_position = get_viewport().get_mouse_position()
	#var test = mouse_position - position

	# get gun type
	# TODO
	var movement_direction = movement_anim.animation

	if movement_direction == "WalkSide":
		punchH()
	if movement_direction == "WalkBackward":
		pass
	if movement_direction == "WalkSForward":
		pass
	if movement_direction == "Idle":
		pass
	


	#var bullet_instance = bullet.instance()

	# fire bullet(s)
	
	#bullet_instance.position = position
	#get_tree().root.add_child(bullet_instance)
	#bullet_instance.set_direction(test.normalized())

	# start cooldown
	#can_attack = false;
	#et_node("Timers").play("GunReload")

func _process(_delta):
	if _check_punch():
		_punch()



func _on_PunchH_Hitbox_body_entered(body:RigidBody2D):

	if !previously_punched.has(body):

		previously_punched[body] = true
		body.damage(10)

		body.apply_central_impulse(
			Vector2(sign(get_parent().scale.x), 0) * punch_force
		)

func _on_Attacks_animation_finished():
	allow_punch()
