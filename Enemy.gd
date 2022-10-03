extends RigidBody2D

#onready var hit_sound_delay: Timer = get_node("HitSoundDelay")
#onready var hit_sound: AudioStreamPlayer = get_node("HitSound")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var next_location: Vector2

var _momentum = Vector2(0,0)

export var movespeed: int = 80

export var health = 100

var player_alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("player_died", self, "_on_player_died")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_player_died():
	player_alive = false
	pass

#func _process(delta):
func damage_enemy(d: int):

	health -= d
	if health <= 0:
		get_parent().remove_child(self)
		queue_free()

func _physics_process(delta):

	if player_alive:
		var momentum = position.move_toward(next_location, delta*movespeed)\
					- position
		apply_central_impulse(momentum)
	rotation_degrees = 0
	#_momentum = move_and_slide(_momentum)

#func _integrate_forces(state):
#	state.linear_velocity = _momentum
