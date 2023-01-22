extends Control


func _ready():
	$HBoxContainer/VBoxContainer2/Score.text = str(Global.points)
	$HBoxContainer/VBoxContainer2/Highscore.text = str(Global.highscore)
	$VBoxContainer/Continue.grab_focus()
	Global.points = 0
	Global.combo = 0
	pass


func _on_Continue_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
