extends Camera2D

@onready var postava1 = get_parent().get_node("postava")
@onready var postava2 = get_parent().get_node("postava2")

@export var maxZoom : float = 0.65
@export var minZoom : float = 1

var maxZ = Vector2(maxZoom, maxZoom)
var minZ = Vector2(minZoom, minZoom)

func _ready():
	zoom = Vector2(0.5, 0.5)

func střed_kamery():
	var středX = (postava2.position.x - postava1.position.x)/2
	var středY = (postava2.position.y - postava1.position.y)/2
	return Vector2(středX,středY)
	
func vzdalenostDvouBodu(a,b):
	var vypocet = (sqrt(((pow(b.x - a.x, 2)) + (pow(b.y - a.y, 2)))))
	if vypocet == 0:
		return Vector2.ZERO
	var vzdalenost = 900/vypocet
	return Vector2(vzdalenost, vzdalenost)

func _physics_process(_delta):
	if is_instance_valid(postava1) && is_instance_valid(postava2):
		offset = postava1.position + střed_kamery()
		var vzdalenost = vzdalenostDvouBodu(postava1.position, postava2.position)
		if vzdalenost != Vector2.ZERO:
			zoom = vzdalenost
			if vzdalenost < maxZ:
				zoom = maxZ
			if vzdalenost > minZ:
				zoom = minZ
	else:
		if is_instance_valid(postava1):
			offset = postava1.position
		elif is_instance_valid(postava2):
			offset = postava2.position
		else:
			get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
