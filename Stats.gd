extends Node

signal stat_change

@export_multiline var description : String
@export var health : float = 100:
	set(value):
		health = value
		stat_change.emit()

@export var max_health : float = 100:
	set(value):
		max_health = value
		stat_change.emit()

@export var armor : float = 5:
	set(value):
		armor = value
		stat_change.emit()

@export var recovery : float = 1:
	set(value):
		recovery = value
		stat_change.emit()

@export var movespeed : float = 5:
	set(value):
		movespeed = value
		stat_change.emit()
@export var stength : float
@export var area : float
@export var magnet : float
@export var growth : float
@export var revival : int
@export var experience : float = 0:
	set(value):
		experience = value
		stat_change.emit()
		
@export var player_level : int = 1:
	set(value):
		player_level = value
		if player_level >= 3:
			Stats.experience += 20
		elif player_level >= 7:
			Stats.experience += 40

# Move this in the future.
var player_pos: Vector2
