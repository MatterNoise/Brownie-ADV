extends Node

@onready var ScreenPanel = $ScreenControl/ScreenPanel
@onready var ScreenWorld = $ScreenControl/ScreenPanel/SubViewport/Main2D

var ProgramName = "Brownie ADV"

var ScreenStretch = 2

func _ready():
	ReadGame("res://Assets/DefaultGame.zip")
	
	get_viewport().size = Vector2i(480, 272) * ScreenStretch
	ScreenPanel.stretch_shrink = ScreenStretch
	
	get_window().move_to_center()

func _process(_delta):
	pass

func CreateItem(NewItem : String):
	var ItemLoaded
	
	match NewItem:
		"Player":
			ItemLoaded = load("res://Scenes/Objects/Players/player_2d.tscn")
		"PongAI":
			ItemLoaded = load("res://Scenes/Objects/Pong/paddle_ai_2d.tscn")
		"Ball":
			ItemLoaded = load("res://Scenes/Objects/Pong/pong_ball_2d.tscn")
		_:
			printerr("'CreateItem' Error!, NewItem no match with 'Assets' objects")
			
			return null
	
	var ItemInstanced = ItemLoaded.instantiate()
	
	add_child(ItemInstanced)
	
	return ItemInstanced

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
		var PlayerOne = CreateItem(JSONData.PlayerOne.Type)
		
		if not (PlayerOne == null):
			PlayerOne.position.x = JSONData.PlayerOne.PositionX
			PlayerOne.position.y = JSONData.PlayerOne.PositionY
		
		#Init Player Two
		var PlayerTwo = CreateItem(JSONData.PlayerTwo.Type)
		
		if not (PlayerTwo == null):
			PlayerTwo.position.x = JSONData.PlayerTwo.PositionX
			PlayerTwo.position.y = JSONData.PlayerTwo.PositionY
		
		#Init Other objects
		var ObjectsList = JSONData.OtherObjects.keys()
		
		for OtherObjectNumber in ObjectsList.size():
			var NewObjectData = JSONData.OtherObjects[ObjectsList[OtherObjectNumber]]
			
			var NewObject = CreateItem(ObjectsList[OtherObjectNumber])
			
			if not (NewObject == null):
				NewObject.position.x = NewObjectData.PositionX
				NewObject.position.y = NewObjectData.PositionY
	else:
		printerr("ZIP Game Reader Error!, 'GameData.json' not found!")
		
		return
