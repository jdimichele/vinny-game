extends CharacterBody2D

var player_nearby: bool = false
var can_attack: bool = true

var base_health: int = 10
var vulnerable: bool = false
var move_speed: float = 1.0

signal skeeter_attack(pos, direction)

func hit():
	if vulnerable:
		base_health -= 10
	if base_health <= 0:
		queue_free()

func _physics_process(delta):
	if(player_nearby):
		look_at(Stats.player_pos)
		position = position.lerp(Stats.player_pos, delta * move_speed)
		
		if can_attack:
			var marker_node = $SkeeterAttackPositions/Attack
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Stats.player_pos).normalized()
			skeeter_attack.emit(pos, direction)
			can_attack = false
			$AttackTimer.start()


func _on_attack_area_body_entered(_body):
	player_nearby = true
