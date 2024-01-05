extends Node

var windowedSeznam:Array = [{
	"name":"Short",
	"size":Vector2(960,540),
},{
	"name":"Medium",
	"size":Vector2(1280,720)
},{
	"name":"Large",
	"size":Vector2(1600,900)
}]
func _ready():
	print(windowedSeznam)
# ulozi defaultni nastaveni
func vytvorNastaveniFile():
	var config = ConfigFile.new()
	
	config.set_value("options","fullscreen",false)
	config.set_value("options","windowedSize",0)
	
	config.save("files/options.cfg")

# nacte
func nactiNastaveniFile():
	var config = ConfigFile.new()
	var err = config.load("files/options.cfg")
	if err != OK:
		print("opening config file failed" +str(err))
		return
	
	if config.get_value("options","fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(windowedSeznam[config.get_value("options","windowedSize")].size)
