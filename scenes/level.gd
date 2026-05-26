extends Node2D
class_name ParentLevel

var attack_scene: PackedScene = preload("res://attacks/vinny_basic_attack.tscn")

func create_attack(pos, direction):
	var attack = attack_scene.instantiate() as Area2D
	attack.position = pos
	attack.rotation_degrees = rad_to_deg(direction.angle())
	attack.direction = direction
	$Attacks.add_child(attack)

func _on_player_attack_input(pos, direction):
	create_attack(pos, direction)
