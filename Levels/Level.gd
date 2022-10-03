extends Navigation2D

export var next_level: String
export var spawn_rate: float = 1.0
export var spawn_count: int = 1

export var spawn_demon1: bool = false
export var spawn_demon2: bool = false
export var spawn_zombie1: bool = false
export var spawn_zombie2: bool = false

onready var enemy_holder = get_node("Enemies")

onready var _base_enemy = preload("res://Enemy.tscn")
onready var _demon_1 = preload("res://Animation/Fisto_Puncho__Demon/AnimatedSpriteDemon.tscn")
onready var _demon_2 = preload("res://Animation/Fisto_Puncho__Demon_2/AnimatedSpriteDemon2.tscn")

onready var spawnpoints = get_node("EnemySpawns").get_children()

var spawn_options: Array = []

# Create array of possible spawns
func _ready():

	Global.next_level = load(next_level)

	get_node("SpawnTimer").wait_time = spawn_rate

	if spawn_demon1:
		spawn_options.append(_demon_1)
	if spawn_demon2:
		spawn_options.append(_demon_2)
	#if spawn_zombie1:
	#	spawn_options.append(_zombie_1)
	#if spawn_zombie2:
	#	spawn_options.append(_zombie_2)

func spawn_enemies():

	if spawn_options.size():

		for _i in range(spawn_count):
			var enemy = _base_enemy.instance()
			var enemy_anim = spawn_options[randi() % spawn_options.size()].instance()

			var spawn_location = spawnpoints[randi() % spawnpoints.size()]

			enemy.add_child(enemy_anim)
			enemy_holder.add_child(enemy)
			enemy.position = spawn_location.position


func _on_SpawnTimer_timeout():
	spawn_enemies()

# next level
func _on_LevelSwitchTimer_timeout():
	Global.emit_signal("next_level")


func _on_MusicStart_timeout():

	get_tree().root.find_node("Music", true, false).play()
	pass # Replace with function body.
