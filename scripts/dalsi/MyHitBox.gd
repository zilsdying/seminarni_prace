class_name MyHitBox
extends Area2D

@export var knockback_power := 500
@export var damage := 1
# layer, mask pomocí bitu
func _init() ->void:
	pass
	#collision_layer = 2 # 2
	#collision_mask = 0 # mimo
