extends Control

#onready var level1 = preload("res://Levels/Level1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.next_level = preload("res://Levels/Level1.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_pressed():
	
	get_parent().change_levels()
	visible = false
	#get_node("../Music").play()
