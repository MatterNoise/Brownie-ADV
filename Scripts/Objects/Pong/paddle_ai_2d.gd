extends CharacterBody2D

@export var PaddleSize = Vector2(16, 48)

var PaddleSpeed = 200

var LockOffScreenMove = true

var PaddleType
var PongBall

func _ready():
	UpdateSettings()

func _process(delta):
	PongBall = get_parent().get_node("PongBall2D")
	
	if not (PongBall == null):
		if PaddleType == "Left":
			if PongBall.position.x > 240:
				if position.y > PongBall.position.y:
					position.y -= delta * PaddleSpeed
				if position.y < PongBall.position.y:
					position.y += delta * PaddleSpeed
		elif PaddleType == "Right":
			if PongBall.position.x < 240:
				if position.y > PongBall.position.y:
					position.y -= delta * PaddleSpeed
				if position.y < PongBall.position.y:
					position.y += delta * PaddleSpeed
	
	position = position.clamp(Vector2(0, 0), Vector2(480, 272))

func UpdateSettings():
	$MeshInstance2D.scale = PaddleSize
	$CollisionShape2D.shape.size = PaddleSize
	
	if position.x < 240:
		PaddleType = "Left"
	else:
		PaddleType = "Right"
