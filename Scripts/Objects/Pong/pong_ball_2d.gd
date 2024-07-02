extends Area2D

@export var BallSpeed = 300
@export var BallSize = 16

var BallStarted = false

var BallCollided = false
var FirstCollision = true

var BallVelocity : Vector2

func _ready():
	UpdateSettings()

func _process(delta):
	if Input.is_action_just_pressed("BallStart") and BallStarted == false:
		BallStarted = true
		FirstCollision = true
		
		BallVelocity = Vector2(-BallSpeed, 0)
	
	if BallStarted == true:
		if (position.x < 1) or (position.x > 479):
			position = Vector2(240, 136)
			
			BallStarted = false
			
			return
		if (position.y < 1) or (position.y > 272):
			BallVelocity.y = -BallVelocity.y
		
		if BallCollided:
			if FirstCollision == true:
				if BallVelocity.x > 0:
					BallVelocity = Vector2(-1, 1) * BallSpeed
				else:
					BallVelocity = Vector2(1, 1) * BallSpeed
				
				FirstCollision = false
			else:
				BallVelocity.x = -BallVelocity.x
		position += delta * BallVelocity
		
		BallCollided = false

func UpdateSettings():
	$MeshInstance2D.scale = Vector2(BallSize, BallSize)
	$CollisionShape2D.shape.size = Vector2(BallSize, BallSize)

func _on_body_entered(body):
	BallCollided = true
