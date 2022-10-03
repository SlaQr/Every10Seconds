extends Area2D

export var bullet_speed = 200.0
var travel_direction = Vector2(1,0)

func set_travel_direction(v2: Vector2):
	travel_direction = v2.normalized()

func set_global_position(v2: Vector2):
	global_position = v2

func _process(delta):
	position += travel_direction * delta * bullet_speed

func _on_BossBullet_body_entered(body:Node):

	if body.has_method("damage"):
		body.damage(10)
	get_parent().call_deferred("remove_child", self)