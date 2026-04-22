extends Node

var HEALTH : int
var ARMOR : int
var STRENGTH : int
var ATTACKSPEED : int
var MOVESPEED : int
var PROJECTILES : int

# possibly add new characters in the future?
enum Characters {
	VINNY,
}

var character_stats = Characters.VINNY

func set_player_stats_on_character():
	match character_stats:
		Characters.VINNY:
			HEALTH = 100
			ARMOR = 10
			STRENGTH = 1
			ATTACKSPEED = 1
			MOVESPEED = 2
			PROJECTILES = 1


@export var player_class = Characters.VINNY
