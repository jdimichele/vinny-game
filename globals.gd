extends Node

signal stat_change

var xp_to_level = 100

var health : float = 100:
	set(value):
		health = value
		%HealthProgressBar.value = value
		stat_change.emit()

var experience = 0:
	set(value):
		experience = value
		stat_change.emit()
		
var player_level = 1:
	set(value):
		player_level = value
		stat_change.emit()
		
func level_up():
	if (experience >= xp_to_level):
		player_level = player_level + 1
		stat_change.emit()
