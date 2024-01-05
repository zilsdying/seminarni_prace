class_name MyHurtBox
extends Area2D
func _init() -> void:
	pass
	#collision_layer = 0 # nic
	#collision_mask = 2 # 2
	
func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox: MyHitBox) -> void:
	if hitbox == null:
		return
	
	if owner.has_method("take_damage"):
		var knockback = global_position - hitbox.global_position
		knockback = (knockback.normalized() * hitbox.knockback_power)
		owner.take_damage(hitbox.damage,knockback)
