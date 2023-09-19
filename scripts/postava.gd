extends CharacterBody2D

var doleva = load("res://pictures/postavicka/left.png")
var doprava = load("res://pictures/postavicka/right.png")
var stát = load("res://pictures/postavicka/standing.png")

@export var postava_id = 1

# rychlost postavy
const SPEED = 300.0

# takzvaně gravitační zrychlení, ale v skákání
const JUMP_VELOCITY = -400.0

# vezme gravitaci hodnotu z tvého projektu, obykle je nastavena (980)
var gravity =ProjectSettings.get_setting("physics/2d/default_gravity")
# funkce, která se spusti několikrát za hru, třeba například 60krát za sekundu, pokud to počítač utáhne
func _physics_process(delta):
	# funkce "is_on_floor()", když se zavolá, tak ti to dá hodnotu závislosti na pevnině (stojíš, nebo ve vzduchu)
	if not is_on_floor():
		# pokud jsi ve vzduchu, vezme to tvoji gravitaci (980) a vynásobíto deltou a dá to y-souřadnici
		velocity.y += gravity * delta
	# pokud stiskneš W/mezerník a jsi na zemi
	if Input.is_action_just_pressed("skok_%s" % [postava_id]) and is_on_floor():
		# přiřadí to k y-souřadnici tvoje "gravitační zrychlení"
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# Vytvoří novou proměnou, do které bude ukládat (-1) a nebo (1), záleží jestli to, co za tlačítko stiskneš
	
	# # funkce "get_axis" vlastně porovnáva, když zmáčkneš první hodnotu "vlevo", tak direction se bude rovnat -1, když opačně, tak 1, a když obojí tak 0 a 0 i když nic neklikneš
	var direction = Input.get_axis("vlevo_%s" % [postava_id], "vpravo_%s" % [postava_id])
	
	if direction == -1:
		get_node("node").texture = doleva
	elif direction == 1:
		get_node("node").texture = doprava
	else:
		get_node("node").texture = stát
		
	# pokud direkce se rovná 1 (doprava) a nebo -1 (doleva)
	# vlastně ta podmínka používá, že všechny hodnoty jsou pravdivé kromě 0 (stojíš) 
	if direction:
		# do rychlosti na x-souřadnici dáš rychlost a vynásobíš stranou
		# příklad Vlevo => -1 * 300 => v=-480 km*h-1? 
		velocity.x = direction * SPEED
	else:
		# do pohyb, to ti vysvětlím kdyžtak, ale sám to moc nechápu
		# hraje to roli,jakmile zastavíš
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# plynulost, funkce, která ti to už udělá plynule
	move_and_slide()



