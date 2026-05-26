extends CharacterBody2D

signal attacking(pos, direction)

@onready var vinny = $AnimatedSprite2D
var can_attack: bool = true

var movement_speed : float = 150
var xp_to_level = 100

func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * movement_speed;
	Stats.player_pos = global_position

	if direction:
		if Input.is_action_pressed("move_left"):
			vinny.play("vinny_ml")
		if Input.is_action_pressed("move_right"):
			vinny.play("vinny_mr")
		if Input.is_action_pressed("move_up"):
			vinny.play("vinny_mu")
		if Input.is_action_pressed("move_down"):
			vinny.play("vinny_md")
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		vinny.play("default")
	
	move_and_collide(velocity * delta)
	basic_attack()
	#health += recovery * delta
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
		
func basic_attack():
	var vinny_pos = Stats.player_pos.round()
	if(can_attack):
		var attack_markers = $AttackPositions.get_children()
		var selected_attack_position = attack_markers[randi() % attack_markers.size()]
		can_attack = false
		$AttackTimer.start()
		attacking.emit(selected_attack_position.global_position, vinny_pos)
		

#func take_damage(amount):
	#health -= max(amount - armor, 0)


func _on_attack_timer_timeout():
	can_attack = true
