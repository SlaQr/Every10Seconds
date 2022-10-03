extends Navigation2D

export var next_level: String
export var spawn_rate: float = 1.0
export var spawn_count: int = 1

export var spawn_demon1: bool = false
export var spawn_demon2: bool = false
export var spawn_zombie1: bool = false
export var spawn_zombie2: bool = false
export var spawn_angel1: bool = false
export var spawn_angel2: bool = false

onready var enemy_holder = get_node("Enemies")

onready var _base_enemy = preload("res://Enemy.tscn")
onready var _demon_1 = preload("res://Animation/Fisto_Puncho__Demon/AnimatedSpriteDemon.tscn")
onready var _demon_2 = preload("res://Animation/Fisto_Puncho__Demon_2/AnimatedSpriteDemon2.tscn")
onready var _zombie_1 = preload("res://Animation/Fisto_Puncho_Zombie_1/AnimatedSpriteZombie1.tscn")
onready var _zombie_2 = preload("res://Animation/Fisto_Puncho_Zombie_2/AnimatedSpriteZombie2.tscn")
onready var _angel_1 = preload("res://Animation/Fisto_Puncho_Angel_1/AnimatedSpriteAngel1.tscn")
onready var _angel_2 = preload("res://Animation/Fisto_Puncho_Angel_2/AnimatedSpriteAngel2.tscn")

onready var spawnpoints = get_node("EnemySpawns").get_children()

var spawn_options: Array = []

var angel1_health = 10
var angel1_speed  = 10
var angel1_drag   = 1

var angel2_health = 10
var angel2_speed  = 10
var angel2_drag   = 1

var zombiel1_health = 10
var zombiel1_speed  = 10
var zombiel1_drag   = 1

var zombie2_health = 10
var zombie2_speed  = 10
var zombie2_drag   = 1

var demon1_health = 10
var demon1_speed  = 10
var demon1_drag   = 1

var demon2_health = 10
var demon2_speed  = 10
var demon2_drag   = 1



# Create array of possible spawns
func _ready():

	Global.next_level = load(next_level)

	get_node("SpawnTimer").wait_time = spawn_rate

	if spawn_demon1:
		spawn_options.append("Demon1")
	if spawn_demon2:
		spawn_options.append("Demon2")
	if spawn_zombie1:
		spawn_options.append("Zombie1")
	if spawn_zombie2:
		spawn_options.append("Zombie2")
	if spawn_angel1:
		spawn_options.append("Angel1")
	if spawn_angel2:
		spawn_options.append("Angel2")

func spawn_enemies():

	if spawn_options.size():

		for _i in range(spawn_count):
			var enemy = _base_enemy.instance()
			var enemy_name = spawn_options[randi() % spawn_options.size()]

			var enemy_anim
			
			if enemy_name == "Demon1":
				enemy_anim = _demon_1.instance()
			if enemy_name == "Demon2":
				enemy_anim = _demon_2.instance()
			if enemy_name == "Zombie1":
				enemy_anim = _zombie_1.instance()
			if enemy_name == "Zombie2":
				enemy_anim = _zombie_2.instance()
			if enemy_name == "Angel1":
				enemy_anim = _angel_1.instance()
			if enemy_name == "Angel2":
				enemy_anim = _angel_2.instance()

			var spawn_location = spawnpoints[randi() % spawnpoints.size()]

			enemy.add_child(enemy_anim)
			enemy_holder.add_child(enemy)
			enemy.position = spawn_location.position

func player_died():
	get_node("LevelSwitchTimer").stop()
	get_node("SpawnTimer").stop()
	get_tree().root.find_node("Music", true, false).stop()

func _on_SpawnTimer_timeout():
	spawn_enemies()

# next level
func _on_LevelSwitchTimer_timeout():
	Global.emit_signal("next_level")


func _on_MusicStart_timeout():

	get_tree().root.find_node("Music", true, false).play()
	pass # Replace with function body.
