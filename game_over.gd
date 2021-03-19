extends Node2D


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		if get_parent().is_game_over():
			get_tree().reload_current_scene()
