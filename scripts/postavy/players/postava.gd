extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const JUMP_VELOCITY = -400.0

@export var postava_id = 1
@export var SPEED:float = 300.0
@export var MAX_HEALTH:int = 6
var currentHealth:int
@onready var animations = $inner/AnimationPlayer
@onready var animsprite2d = $inner/AnimatedSprite2D
@onready var weapon = $inner/AnimatedSprite2D/weapon
@onready var inner = $inner


func _ready():
	currentHealth = MAX_HEALTH

func take_damage(amount,knockback):
	velocity = knockback
	move_and_slide()
	currentHealth -= amount
	if currentHealth<=0:
		queue_free()

func attack():
	animations.play("sword")
	weapon.visible = true
	await animations.animation_finished
	weapon.visible = false


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("skok_%s" % [postava_id]) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("attack_%s" % [postava_id]):
		attack()
	
	var direction = Input.get_axis("vlevo_%s" % [postava_id], "vpravo_%s" % [postava_id])
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animsprite2d.play("idle")
	else:
		velocity.x = direction * SPEED
		inner.scale.x = -sign(direction) if direction != 0.0 else -1.0
		animsprite2d.play("walk")
	move_and_slide()

#func knockback(enemyVelocity: Vector2,knockbackPower):
#	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
#	velocity = knockbackDirection
#	print(velocity)
#	move_and_slide()
