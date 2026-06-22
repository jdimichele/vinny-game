extends CharacterBody2D

signal attacking(pos, direction)

@onready var vinny = $AnimatedSprite2D
var can_attack: bool = true
var movement_speed : float = 150
var xp_to_level = 100
var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#if(direction):
		#if (Input.is_action_pressed("move_left")):
			#vinny.play("vinny_ml")
			#if (can_attack):
				#can_attack = false
				#$AttackTimer.start()
				#var attack_left = $AttackPositions/MarkerLeft
				#attacking.emit(attack_left.global_position, direction)
	
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		vinny.play("default")
		if (can_attack):
			can_attack = false
			$AttackTimer.start()
			var attack_right = $AttackPositions/MarkerRight
			attacking.emit(attack_right.global_position, direction)
		
		
	
	#TODO: Need to fix static spawn of the attack only being on Vinny
	#if(!direction and can_attack):
		#can_attack = false
		#$AttackTimer.start()
		#var attack_right = $AttackPositions/MarkerRight
		#attacking.emit(attack_right.global_position, direction)
	movement()
	take_damage(10)
	health_recovery(delta)
	check_XP()

func check_XP():
	if(Stats.experience >= xp_to_level):
		level_up()

func level_up():
	if(Stats.experience >= xp_to_level):
		Stats.player_level += 1
		Stats.max_health += 5
		Stats.health = Stats.max_health
		Stats.experience = 0

func take_damage(amount):
	if Input.is_action_pressed("take_damage"):
		Stats.health -= amount
	
func health_recovery(delta):
	Stats.health += Stats.recovery * delta

func movement():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var move = Vector2(x_movement, y_movement)
	
	if move.x > 0:
		vinny.play("vinny_mr")
	elif move.x < 0:
		vinny.play("vinny_ml")
	
	if move.y > 0:
		vinny.play("vinny_md")
	elif move.y < 0:
		vinny.play("vinny_mu")
	
	velocity = move.normalized() * movement_speed
	move_and_slide()
	

func _on_attack_timer_timeout():
	can_attack = true
