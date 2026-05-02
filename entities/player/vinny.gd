extends CharacterBody2D

@onready var vinny = $AnimatedSprite2D

var health : float = 100:
	set(value):
		health = value
		%HealthProgressBar.value = value
var movement_speed : float = 150
var max_health : float = 100:
	set(value):
		max_health = value
		%HealthProgressBar.max_value = value
var recovery : float = 0
var armor : float = 0
var might : float = 1.0
var area : float = 0


var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value
var total_XP : int = 0
var level : int = 1:
	set(value):
		level = value
		$PlayerLevel/VBoxContainer/Label.text = "Lvl " + str(value)
		%Options.show_option()
		
		if level >= 3:
			%XP.max_value = 20
		elif level >= 7:
			%XP.max_value = 40


func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * movement_speed;

	if direction:
		if Input.is_action_pressed("move_left"):
			vinny.play("vinny_ml")
		if Input.is_action_pressed("move_right"):
			vinny.play("vinny_mr")
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		vinny.play("new_vinny")
	
	health += recovery * delta
	#check_XP()
	move_and_collide(velocity * delta)


func take_damage(amount):
	health -= max(amount - armor, 0)
