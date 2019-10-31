extends Control

func _ready():
	$ColorRect/Score.set_text(str("Score Kamu : ",Global.Score))

func _on_Button_pressed():
	get_tree().change_scene("res://src/Scene/GUI/TitleScreen.tscn")
