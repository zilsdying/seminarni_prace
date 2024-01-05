extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction:int = 1

@export var speed:int = 50
@onready var animsprite2d = $inner/AnimatedSprite2D
@onready var inner = $inner
func _ready() -> void:
	animsprite2d.play("walk")
	direction = -1

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.x += speed * delta * direction
	move_and_slide()


func _on_detection_body_entered(body):
	if body.name == "TileMap" || (body.name == "postava" || body.name == "postava2"):
		inner.scale.x = sign(direction) if direction != 0.0 else -1.0
		direction *= -1

func _on_s_my_hurt_box_body_entered(body):
	if body.name == "postava" || body.name =="postava2":
		if body.is_on_floor():
			queue_free()
