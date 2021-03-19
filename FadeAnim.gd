extends Node2D

func _enter_tree():
	get_tree().paused = true


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		$AnimationPlayer.play("panel_fade")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().paused = false
	hide()


