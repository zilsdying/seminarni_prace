extends Area2D

func _on_body_entered(body):
	Global.stars +=1
	if body.name == "postava" or body.name == "postava2":
		queue_free()
