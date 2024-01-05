extends CharacterBody2D
var currentHealth:int
var player_chase = false
var player = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var slupka = true
@export var speed:int = 50
@export var MAX_HEALTH :int = 3
@export var after_slupka_health:int = 1
@onready var animsprite2d = $inner/AnimatedSprite2D
@onready var inner = $inner
var walk = 1
func _ready() -> void:
	currentHealth = MAX_HEALTH
	animsprite2d.play("idle")

func take_damage(amount,knockback):
	velocity = knockback
	move_and_slide()
	currentHealth -= amount
	if currentHealth<=0 && slupka == true:
		slupka=false
		currentHealth = after_slupka_health
		walk = 2
	if currentHealth<=0 && slupka == false:
		queue_free()
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if player_chase:
		position += (player.owner.position + player.position - position)/speed
		animsprite2d.play("walk"+str(walk))
		if(player.owner.position.x + player.position.x - position.x) < 0:
			inner.scale.x = sign(1)
		else:
			inner.scale.x = sign(-1)
	else:
		velocity.x = 0
		animsprite2d.play("idle")
	move_and_slide()
		
func _on_detection_area_body_entered(body):
	player = body
	player_chase = tr
func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
