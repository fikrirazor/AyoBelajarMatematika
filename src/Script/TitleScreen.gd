extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	MusicBackground.play()
	for button in $Menu/Button.get_children():
		if button is TextureButton:
			button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	BtnClick.play()
	get_tree().change_scene(scene_to_load)


func _on_BtnClose_pressed():
	get_tree().quit()


func _on_BtnSetting_pressed():
	$Setting.show()


func _on_BtnAbout_pressed():
	$Tentang.show()
