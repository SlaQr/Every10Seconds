extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var next_location: Vector2

var _momentum = Vector2(0,0)

export var movespeed: int = 80
export var preserved_momentum = 0.8

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):

	_momentum *= preserved_momentum
	_momentum += position.move_toward(next_location, delta*movespeed)\
				 - position
	_momentum = move_and_slide(_momentum)
