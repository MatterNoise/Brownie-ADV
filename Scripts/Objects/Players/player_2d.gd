extends CharacterBody2D

@export var PlayerType = "PlayerOne"

@export var PaddleSize = Vector2(16, 48)

@export var LockMoveX = false
@export var LockMoveY = false
@export var LockOffScreenMove = true

var PlayerSpeed = 200

func _ready():
	UpdateSettings()

func _process(delta):
	if LockMoveY == false:
		if Input.is_action_pressed(PlayerType + "ButtonUp"):
			position.y -= delta * PlayerSpeed
		if Input.is_action_pressed(PlayerType + "ButtonDown"):
			position.y += delta * PlayerSpeed
	
	if LockMoveX == false:
		if Input.is_action_pressed(PlayerType + "ButtonLeft"):
			position.x -= delta * PlayerSpeed
		if Input.is_action_pressed(PlayerType + "ButtonRight"):
			position.x += delta * PlayerSpeed
	
	if LockOffScreenMove == true:
		position = position.clamp(Vector2(0, 0), Vector2(480, 272))

func UpdateSettings():
	$MeshInstance2D.scale = PaddleSize
	$CollisionShape2D.shape.size = PaddleSize
