extends Node

@onready var ScreenPanel = $ScreenControl/ScreenPanel

@onready var DefaultGame = preload("res://Assets/default_game.tres")

var ScreenStretch = 2

func _ready():
	get_viewport().size = Vector2i(480, 272) * ScreenStretch
	ScreenPanel.stretch_shrink = ScreenStretch
	
	get_window().move_to_center()

func _process(delta):
	pass
