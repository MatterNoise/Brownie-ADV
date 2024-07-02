extends CharacterBody2D

@export var PlayerPaddle = "PlayerOne"

@export var PaddleSize = Vector2(16, 48)

var PaddleSpeed = 200

var LockMoveX = true
var LockMoveY = false
var LockOffScreenMove = true

func _ready():
	UpdateSettings()

func _process(delta):
	if LockMoveY == false:
		if Input.is_action_pressed(PlayerPaddle + "ButtonUp"):
			position.y -= delta * PaddleSpeed
		if Input.is_action_pressed(PlayerPaddle + "ButtonDown"):
			position.y += delta * PaddleSpeed
	
	if LockMoveX == false:
		if Input.is_action_pressed(PlayerPaddle + "ButtonLeft"):
			position.x -= delta * PaddleSpeed
		if Input.is_action_pressed(PlayerPaddle + "ButtonRight"):
			position.x += delta * PaddleSpeed
	
	if LockOffScreenMove == true:
		position = position.clamp(Vector2(0, 0), Vector2(480, 272))

func UpdateSettings():
	$MeshInstance2D.scale = PaddleSize
	$CollisionShape2D.shape.size = PaddleSize
