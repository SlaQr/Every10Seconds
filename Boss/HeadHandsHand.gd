extends AnimatedSprite

onready var bullet_spawn_host = get_node("Bulletspawns")
onready var bullet = preload("res://Boss/BossBullet.tscn")


onready var parent_position = get_parent().position
var delay = 0.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var shake = false

var shake_strength = 8

var free_move = true

var seek_position = false
var seeked_position: Vector2

func open_hand_shake():
	free_move = false
	play("floating")
	get_node("Area2D").monitoring = true
	shake = true
	shake_strength = 4

func slam_fist():
	play("smash")
	shake_strength = 12
	spawn_bullets()

func back_to_floating():
	get_node("Area2D").monitoring = false
	play("floating")
	free_move = true
	shake = false

func spawn_bullets():
	for spawn_location in bullet_spawn_host.get_children():
		var b = bullet.instance()
		get_parent().get_parent().call_deferred("add_child", b)
		b.call_deferred("set_global_position", spawn_location.global_position)
		b.travel_direction = global_position.direction_to(spawn_location.global_position)

func set_random_movement():
	var positions = get_node("../HandPositions").get_children()
	seek_position = true
	seeked_position = positions[randi() % positions.size()].global_position

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("Attacks").play("BulletSmash")
	seek_position = true
	seeked_position = Vector2(300, 300)

	delay = get_parent().get_parent().delay

func _process(delta):

	print(delay)
	if delay > 0:
		delay -= delta
		return

	get_node("Attacks").play("BulletSmash")
	if shake:
		get_parent().position = parent_position + Vector2(
			rand_range(-shake_strength, shake_strength),
			rand_range(-shake_strength, shake_strength))
	else:
		get_parent().position = parent_position
	
	if seek_position:

		var weight = 0.95

		global_position = (global_position * weight) + \
				   (seeked_position * (1-weight))
