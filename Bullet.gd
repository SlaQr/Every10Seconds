extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var travel_direction: Vector2

var travel_speed = 600


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_direction(v2):
	travel_direction = v2

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	position += travel_direction * travel_speed * delta