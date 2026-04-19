extends CharacterBody2D

@onready var vinny = $AnimatedSprite2D

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED;

	if direction:
		if Input.is_action_pressed("move_left"):
			vinny.play("vinny_ml")
		if Input.is_action_pressed("move_right"):
			vinny.play("vinny_mr")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		vinny.play("default")

	move_and_slide()
