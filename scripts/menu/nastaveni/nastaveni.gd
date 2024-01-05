extends Node

var config = ConfigFile.new()

@onready var err = config.load("res://files/options.cfg")
@onready var fullscreenButton = get_node("MarginContainer/VBoxContainer/HBoxContainer/FullscreenButton")
@onready var optionButton = get_node("MarginContainer/VBoxContainer/HBoxContainer/OptionButton")
@onready var saveload = SaveLoad
# fullscreen
func _ready():
	if err != OK:
		print("chyba nacteni")
		return
	fullscreenButton.button_pressed = config.get_value("options","fullscreen")
	optionButton.disabled = config.get_value("options","fullscreen")
	for item in saveload.windowedSeznam:
		optionButton.add_item(item.name)
	optionButton.selected = config.get_value("options","windowedSize")
	
	

func _on_check_button_pressed():
	if fullscreenButton.button_pressed:
		config.set_value("options","fullscreen",true)
	else:
		config.set_value("options","fullscreen",false)
	optionButton.disabled = !optionButton.disabled
	

func _on_back_pressed():
	#config.save("res://files/options.cfg")
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")


func _on_option_button_item_selected(index):
	config.set_value("options","windowedSize",index)


func _on_save_pressed():
	config.save("res://files/options.cfg")
	saveload.nactiNastaveniFile()
