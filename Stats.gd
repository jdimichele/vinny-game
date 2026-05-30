extends Node

signal stat_change

@export_multiline var description : String
@export var health : int = 100:
	set(value):
		health = value
		stat_change.emit()

@export var max_health : int = 100:
	set(value):
		max_health = value
		stat_change.emit()

@export var armor : int = 1:
	set(value):
		armor = value
		stat_change.emit()

@export var recovery : int = 1:
	set(value):
		recovery = value
		stat_change.emit()

@export var movespeed : int = 5:
	set(value):
		movespeed = value
		stat_change.emit()

@export var stength : int 
@export var area : int 
@export var magnet : int = 1
@export var growth : int 
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
