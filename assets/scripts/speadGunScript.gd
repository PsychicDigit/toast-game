extends Sprite2D


const jellyShot = preload("res://scenes/jelly_shot.tscn")

@onready var muzzle: Marker2D = $Marker2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	if Input.is_action_just_pressed("jellyShot"):
		var jellyShotInstance = jellyShot.instantiate()
		get_tree().root.add_child(jellyShotInstance)
		jellyShotInstance.global_position = muzzle.global_position
		jellyShotInstance.rotation = rotation
