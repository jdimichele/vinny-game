extends CharacterBody2D

var player_nearby: bool = false
var can_attack: bool = true

var base_health: int = 100
var move_speed: float = 0.2

signal skeeter_attack(pos, direction)

func hit():
	base_health -= Stats.player_dmg
	print(base_health)
	if base_health <= 0:
		queue_free()

func _process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if(player_nearby):
		look_at(Stats.player_pos)
		position = position.lerp(Stats.player_pos, delta * move_speed)
		
		if can_attack:
			var marker_node = $SkeeterAttackPositions/Attack
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Stats.player_pos)
			skeeter_attack.emit(pos, direction)
			can_attack = false
			$AttackTimer.start()



func _on_attack_area_body_entered(_body):
	player_nearby = true
