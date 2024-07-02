extends CharacterBody2D

@export var PaddleSize = Vector2(16, 48)

var PaddleType = "Right"
var PaddleSpeed = 3.25

var LockOffScreenMove = true

var PongBall

func _ready():
	UpdateSettings()

func _process(delta):
	PongBall = get_parent().get_node("PongBall2D")
	
	if not PongBall == null:
		if PaddleType == "Left":
			if PongBall.position.x < 240:
				if position.y > PongBall.position.y:
					position.y -= PaddleSpeed
				if position.y < PongBall.position.y:
					position.y += PaddleSpeed
		elif PaddleType == "Right":
			if PongBall.position.x > 240:
				if position.y > PongBall.position.y:
					position.y -= PaddleSpeed
				if position.y < PongBall.position.y:
					position.y += PaddleSpeed
	
	position = position.clamp(Vector2(0, 0), Vector2(480, 272))

func UpdateSettings():
	$MeshInstance2D.scale = PaddleSize
	$CollisionShape2D.shape.size = PaddleSize
