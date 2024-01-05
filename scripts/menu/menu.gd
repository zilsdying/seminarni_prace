extends Control
@onready var saveLoad = SaveLoad

func _ready():
	$"MarginContainer/VBoxContainer/začít_button".grab_focus()
	if FileAccess.file_exists("files/options.cfg"):
		saveLoad.nactiNastaveniFile()
	else:
		saveLoad.vytvorNastaveniFile()

func _on_začít_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")

func _on_nastavení_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/nastavení.tscn")

func _on_odejít_button_pressed():
	get_tree().quit()
