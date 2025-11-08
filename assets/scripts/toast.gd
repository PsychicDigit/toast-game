extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var stuckOnPeanutButter = false;


func _physics_process(delta: float) -> void:
	# Add the gravity with respect to peanut butter
	if not is_on_floor() and not stuckOnPeanutButter:
		velocity += get_gravity() * delta
	
	# Handle jump with respect to peanut butter
	if Input.is_action_just_pressed("jump") and (is_on_floor() or stuckOnPeanutButter):
		velocity.y = JUMP_VELOCITY
	elif not Input.is_anything_pressed() and stuckOnPeanutButter:
		velocity.y = 0

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	
	# collision stuff
	
	# if there are no collisions, set stuckonpeanutbutter to false. this prevents a bug where the player becomes stuck on peanut butter with no way to unstick
	if get_slide_collision_count() == 0:
		stuckOnPeanutButter = false
	
	# go through every current collision the player has with other physics bodies. check the names of colliders to determine if the player is stuck on a spread, and make the player react accordingly
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if "PeanutButter" in collision.get_collider().name:
			stuckOnPeanutButter = true
			
		elif "Jelly" in collision.get_collider().name:
			velocity.y = JUMP_VELOCITY * 2
	
	move_and_slide()
