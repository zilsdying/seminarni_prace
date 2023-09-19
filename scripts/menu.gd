extends Control

func _ready():
	$"MarginContainer/VBoxContainer/začít_button".grab_focus()

func _on_začít_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")

func _on_nastavení_button_pressed():
	get_tree().change_scene_to_file("res://scenes/nastavení.tscn")

func _on_odejít_button_pressed():
	get_tree().quit()
