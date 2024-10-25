extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

var is_jumping := false

@onready var animation:=$animator as AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor():
			is_jumping = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction !=0:
		velocity.x = direction * SPEED
		animation.play("run")
		animation.scale.x = direction
		if !is_jumping:
			animation.play("run")
		elif is_jumping:
			animation.play("jump")
	else:
		#animation.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
