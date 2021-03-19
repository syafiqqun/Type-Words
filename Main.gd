extends Node2D

var text_label = preload("res://TextLabel.tscn")

onready var score_label = $Score
onready var text_spawner = $TextSpawner

export var debug = true
var pause_state = false

var score = 0
var text_type = ""

var try = 5

var word_entered = []

var index = 0

var word_list = ["word", "godotte", "giraffe", "score", "godot", "billboard", "carry", "dare", "game", "bicycle", "random", "cat", "eating", "learning",
"chicken", "product", "airplane", "dictionary", "animation", "earth", "anime", "number", "hello", "world", "programming", "coding", "integer", "school",
"platinum", "merchant", "eye", "squid", "monkey", "banana", "apple", "food", "anatomy", "elastic", "going", "door", "node", "scritping", "hard", "impossible",
"astronaut", "music", "computer", "shop", "banking", "durian", "keyboard", "piano", "guitar", "pimple", "face", "water", "ocean", "sky", "sun", "running",
"dinosaur", "citrus", "time", "minute", "television", "impudent", "angry", "smile", "sadistic", "suprise", "coffe", "milk", "raisin", "invisible", "normal"]

# spawn word every (n)second
var spawner_timer = 1

var rng = RandomNumberGenerator.new()
var current_int = 0

var ms = 0
var s = 0

var game_over = false

func _physics_process(delta):
	# spawn text label
	ms += 1
	if ms > 60:
		s += 1
		ms = 0
	if s > spawner_timer:
		current_int = random_number()
		
		var n = text_label.instance()
		n.text = word_list[current_int]
		n.rect_position = Vector2(rand_int(), -44)
		$TextSpawner.add_child(n)
		
		print(word_list[current_int])
		
		s = 0


func _input(event):
	
	if Input.is_action_just_pressed("ui_accept"):
		
		for t in word_entered:
			# check whether the text type is the same as any of the word in word_entered
			if text_type == t:
				# delete word in word_entered
				word_entered.erase(t)
				# delete the corresponding node
				var node_text = text_spawner.get_children()
				for n in node_text:
					if n.text == text_type:
						n.queue_free()
				
				# add score
				score += 20
				# set the label to the latest score value
				score_label.text = "Score : " + str(score)
				
			index += 1
			
		debug_text(word_entered)
		
		# reset index value
		index = 0


func rand_int():
	rng.randomize()
	return rng.randi_range(120, 880)


func random_number():
	rng.randomize()
	return rng.randi_range(0, word_list.size() - 1)


func debug_text(val):
	if debug == true:
		print(val)


func is_game_over():
	return game_over


func _on_TextEdit_text_changed():
	# get all the text before the curso
	text_type = $TextEdit.get_line($TextEdit.cursor_get_line())


func _on_Area2D_area_entered(area):
	# add text to the word_entered list
	var area_enter_node = area.get_parent()
	word_entered.append(area_enter_node.text)
	
	print("word entered", word_entered)


func _on_AreaExit_area_entered(area):
	# remove the node after out of the area
	var area_enter = area.get_parent()
	print(area_enter.text)
	
	word_entered.erase(area_enter.text)
	area_enter.queue_free()
	
	print("word after delete", word_entered)
	
	try -= 1
	$Try.text = "Try : " + str(try)
	if try < 1:
		$Node2D.show()
		$Node2D/BestScore.text = "Best Score : " + str(score)
		game_over = true
		get_tree().paused = true


func _on_PauseButton_pressed():
	pause_state = !pause_state
	
	if pause_state == true:
		get_tree().paused = true
		$Button.text = "Continue"
	else:
		get_tree().paused = false
		$Button.text = "Pause"
