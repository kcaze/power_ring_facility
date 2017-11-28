extends Node2D

export var level_number = 1

func _ready():
	Globals.set('current_level', level_number)
	Globals.set('level_map', [
		'null',
		'res://level1-1.tscn',
		'res://level1-2.tscn',
		'res://level1-3.tscn',
		'res://level2-1.tscn',
		'res://level2-2.tscn',
		'res://credits.tscn',
	])