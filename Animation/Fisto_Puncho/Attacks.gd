extends AnimatedSprite

onready var player = get_parent().get_parent()
onready var punchH_hitbox = get_node("../PunchH_Hitbox")
onready var punchU_hitbox = get_node("../PunchU_Hitbox")
onready var punchD_hitbox = get_node("../PunchD_Hitbox")
onready var movement_anim = get_node("../Movement")
onready var punch_swing: AudioStreamPlayer = get_node("../../Sound/PunchSwing")
onready var punch_hit: AudioStreamPlayer = get_node("../../Sound/PunchHit")
onready var punch_hit_delay: Timer = get_node("../../Sound/PunchHitDelay")
onready var hurtbox_diabler: Timer = get_node("../HurtboxDisabler")

onready var attacks2 = get_node("../Attacks2")

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

func punchD():
	attacks2.z_index = 3
	punchD_hitbox.monitoring = true
	attacks2.visible = true
	can_punch = false

	attacks2.play("PunchD")

func punchU():
	attacks2.z_index = 1
	punchU_hitbox.monitoring = true
	attacks2.visible = true
	can_punch = false

	attacks2.play("PunchU")

func _check_punch():
	return Input.is_action_pressed("plr_fire") and can_punch

func disable_hitboxes():
	punchH_hitbox.monitoring = false
	punchU_hitbox.monitoring = false
	punchD_hitbox.monitoring = false
	
func allow_punch():
	visible = false
	attacks2.visible = false
	can_punch = true

func _punch():

	previously_punched.clear()
	hurtbox_diabler.start(0.08)

	var movement_direction = movement_anim.animation

	if movement_direction == "WalkSide":
		punch_swing.play()
		punchH()
	if movement_direction == "WalkBackward":
		punch_swing.play()
		punchU()
	if movement_direction == "WalkForward":
		punch_swing.play()
		punchD()
	if movement_direction == "Idle":
		pass
	
func shoot():
	pass
	# get fire direction
	#var mouse_position = get_viewport().get_mouse_position()
	#var test = mouse_position - position

	# get gun type
	# TODO

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

		if previously_punched.empty():
			punch_hit_delay.start(0.15)

		previously_punched[body] = true
		body.damage_enemy(10)

		body.apply_central_impulse(
			Vector2(sign(get_parent().scale.x), 0) * punch_force
		)


func _on_PunchD_Hitbox_body_entered(body:Node):
	if !previously_punched.has(body):

		if previously_punched.empty():
			punch_hit_delay.start(0.15)

		previously_punched[body] = true
		body.damage_enemy(10)

		body.apply_central_impulse(
			Vector2(0, 1) * punch_force
		)

func _on_PunchU_Hitbox_body_entered(body:Node):
	if !previously_punched.has(body):

		if previously_punched.empty():
			punch_hit_delay.start(0.15)

		previously_punched[body] = true
		body.damage_enemy(10)

		body.apply_central_impulse(
			Vector2(0, -1) * punch_force
		)

func _on_PunchHitDelay_timeout():
	punch_hit.play()

func _on_HurtboxDisabler_timeout():
	disable_hitboxes()

func _on_Attacks_animation_finished():
	allow_punch()

