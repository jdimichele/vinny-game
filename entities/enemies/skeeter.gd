extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var experience_node = preload("res://items/experience.tscn").instantiate()

var player_nearby: bool = false
var can_attack: bool = true

var base_health: int = 20
var move_speed: float = 0.2

signal enemy_attack(pos, direction)

func _process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if(player_nearby):
		look_at(Stats.player_pos)
		position = position.lerp(Stats.player_pos, delta * move_speed)
		
		if can_attack:
			var marker_node = $EnemyAttackPosition/EnemyAttack
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Stats.player_pos)
			enemy_attack.emit(pos, direction)
			can_attack = false
			$AttackTimer.start()

func hit():
	base_health -= Stats.player_dmg
	print(base_health)
	if base_health <= 0:
		get_parent().add_child(experience_node)
		experience_node.global_position = global_position
		queue_free()


func _on_area_2d_body_entered(_body):
	player_nearby = true
