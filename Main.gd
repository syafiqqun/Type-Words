extends Node2D

onready var score_label = $Score
onready var text_spawner = $TextSpawner

export var debug = true

var score = 0
var text_type = ""

var word_entered = []

var number_of_word = 0
var index = 0

var word_list = ["word", "godot", "giraffe", "score"]

# spawn word every 5 seconds
var spawner_timer = 0

var pause_state = false

func _process(delta):
	pass


func _input(event):
	
	if Input.is_action_just_pressed("ui_accept"):
		
		for t in word_entered:
			# check whether the text type is the same as any of the word in word_entered
			if text_type == t:
				
				debug_text(t)
				
				word_entered.erase(t)
				text_spawner.get_child(index).queue_free()
				number_of_word = 0
				
				# add score
				score += 20
				# set the label to the latest score value
				score_label.text = "Score : " + str(score)
				
			index += 1
			
		debug_text(word_entered)
		
		# reset index value
		index = 0


func debug_text(val):
	if debug == true:
		print(val)


func _on_TextEdit_text_changed():
	# get all the text before the curso
	text_type = $TextEdit.get_line($TextEdit.cursor_get_line())


func _on_Area2D_area_entered(area):
	# add text to the word_entered list
	var node = text_spawner.get_child(number_of_word)
	word_entered.append(node.text)
	number_of_word += 1
	
	debug_text(word_entered)


func _on_Area2D_area_exited(area):
	pass


func _on_Button_pressed():
	pause_state = !pause_state
	
	if pause_state == true:
		get_tree().paused = true
		$Button.text = "Continue"
	else:
		get_tree().paused = false
		$Button.text = "Pause"
