extends CharacterBody2D

signal attacking(pos, direction)

@onready var vinny = $AnimatedSprite2D
var can_attack: bool = true
var movement_speed : float = 150
var xp_to_level = 100

func _ready():
	if(Input.is_action_pressed("take_damage")):
		take_damage(10)

func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * movement_speed;
	Stats.player_pos = global_position
	move_and_slide()
	
	if direction:
		if (Input.is_action_pressed("move_left")):
			vinny.play("vinny_ml")
			if (can_attack):
				can_attack = false
				$AttackTimer.start()
				var attack_left = $AttackPositions/MarkerLeft
				attacking.emit(attack_left.global_position, direction)
		if (Input.is_action_pressed("move_right")):
			vinny.play("vinny_mr")
			if (can_attack):
				can_attack = false
				$AttackTimer.start()
				var attack_right = $AttackPositions/MarkerRight
				attacking.emit(attack_right.global_position, direction)
		if (Input.is_action_pressed("move_up")):
			vinny.play("vinny_mu")
			if(can_attack):
				can_attack = false
				$AttackTimer.start()
				var attack_up = $AttackPositions/MarkerUp
				attacking.emit(attack_up.global_position, direction)
		if (Input.is_action_pressed("move_down")):
			vinny.play("vinny_md")
			if(can_attack):
				can_attack = false
				$AttackTimer.start()
				var attack_down = $AttackPositions/MarkerDown
				attacking.emit(attack_down.global_position, direction)
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		vinny.play("default")
	
	#TODO: Need to fix static spawn of the attack only being on Vinny
	#if(!direction and can_attack):
		#can_attack = false
		#$AttackTimer.start()
		#var attack_right = $AttackPositions/MarkerRight
		#attacking.emit(attack_right.global_position, direction)
		
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
	Stats.health = Stats.health - amount
	
func health_recovery(delta):
	Stats.health += Stats.recovery * delta


func _on_attack_timer_timeout():
	can_attack = true
