extends Node

@onready var ScreenPanel = $ScreenControl/ScreenPanel
@onready var ScreenWorld = $ScreenControl/ScreenPanel/SubViewport/Main2D

var ProgramName = "Brownie ADV"

var ScreenStretch = 2

func _ready():
	get_viewport().size = Vector2i(480, 272) * ScreenStretch
	ScreenPanel.stretch_shrink = ScreenStretch
	
	get_window().move_to_center()
	
	ReadGame("res://Assets/DefaultGame.zip")

func _process(delta):
	pass

func ReadGame(File : String):
	#Delete the last session
	if ScreenWorld.get_children():
		print("'ScreenWorld' Has Childens!, Deleting Childs...")
		
		for WorldChild in ScreenWorld.get_children():
			if (not WorldChild.name == "ScreenBG"):
				WorldChild.queue_free()
	
	#Init Default Game
	var ZIPManager = ZIPReader.new()
	var JSONManager = JSON.new()
	
	var FileError = ZIPManager.open(File)
	if FileError == OK:
		print("ZIP Game Readed sucessfuly!")
	else:
		printerr("ZIP Game Reader Error!, File not found!")
		
		return
	
	if ZIPManager.file_exists("GameData.json"):
		print("Reading 'GameData.json'")
		
		var GameData = ZIPManager.read_file("GameData.json")
		var FileBuffer = GameData.get_string_from_ascii()
		var JSONReadError = JSONManager.parse(FileBuffer)
		
		if JSONReadError != OK:
			printerr("ZIP Game Reader Error!, JSON parsing error!")
			
			return
		
		var JSONData = JSONManager.data
		
		get_window().title = ProgramName + " (Now Playing: " + JSONData.GameTitle + ")"
		
		#Init Player One
		JSONData.PlayerOne.Type
		
		JSONData.PlayerOne.PositionX
	else:
		printerr("ZIP Game Reader Error!, 'GameData.json' not found!")
		
		return
