extends CharacterBody2D

var notpunch = true
const SPEED = 130.0
const RUN_SPEED = 400.0
const JUMP_VELOCITY = -600.0
@onready var animation = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	var direction = Input.get_axis("left", "right")
	if direction && notpunch == true:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_pressed("run") && notpunch == true:
		velocity.x = direction * RUN_SPEED
		
	if Input.is_action_just_pressed("Attack"):
		#damage here
		notpunch = false
		animation.play("Punch")
	if animation.frame == 7:
		notpunch = true
		
	if Input.is_action_just_pressed("attack_r"):
		#damage here
		notpunch = false
		animation.play("Jab")
	if animation.frame == 7:
		notpunch = true
	move_and_slide()
	
	if (notpunch == true) :
		if velocity.x == 0:
			animation.play("Idle")
		if direction :
			if velocity.x == -SPEED:
				animation.flip_h = true
				animation.play("Walk")
			if velocity.x == SPEED:
				animation.flip_h = false
				animation.play("Walk")
			if velocity.x == -RUN_SPEED:
				animation.flip_h = true
				animation.play("Run")
			if velocity.x == RUN_SPEED:
				animation.flip_h = false
				animation.play("Run")
		if velocity.y < 0 :
			animation.play("Jump")
		if velocity.y > 0 :
			animation.play("Fall")
		

