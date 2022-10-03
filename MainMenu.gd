extends Control

#onready var level1 = preload("res://Levels/Level1.tscn")

onready var player = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.next_level = preload("res://Levels/Level1.tscn")
	Global.connect("player_died", self, "_on_player_death")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_player_death():

	get_tree().change_scene(get_tree().current_scene.filename)

	#get_parent().reload_current_scene()
	#$visible = true
	#$player.health = 100
	#$player.position = Vector2(-400, -400)
	#$Global.next_level = preload("res://Levels/Level1.tscn")

func _on_Start_pressed():
	
	get_parent().change_levels()
	visible = false
	#get_node("../Music").play()
