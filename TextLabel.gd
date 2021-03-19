extends Button


func _physics_process(delta):
	rect_position += Vector2(0, 1)
	
	if rect_position.y > 496:
		hide()
