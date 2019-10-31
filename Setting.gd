extends Popup


func _on_Button_pressed():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music Background"), 0)

func _on_Button2_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music Background"), false)

func _on_Menu_pressed():
	self.hide()

func _on_Button3_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music Background"), true)


func _on_HSlider_changed():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music Background"), 0)


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music Background"), value)


func _on_MainMenu_pressed():
	get_tree().change_scene("res://src/Scene/GUI/TitleScreen.tscn")


func _on_Keluar_pressed():
	$PopupKonfirmasi.show()


func _on_Ya_pressed():
	get_tree().quit()


func _on_Tidak_pressed():
	$PopupKonfirmasi.hide()
