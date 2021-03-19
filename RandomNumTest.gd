extends Node2D



var word_list = ["godot", "billboard", "carry", "dare", "game", "bicycle", "random", "cat", "eating", "learning"]

var rng = RandomNumberGenerator.new()

var current_int = 0

var ms = 0
var s = 0

func _ready():
	pass

func random_number():
	rng.randomize()
	return rng.randi_range(0, word_list.size() - 1)


func _physics_process(delta):
	
	# spawn text label
	ms += 1
	if ms > 60:
		s += 1
		ms = 0
	if s > 3:
		current_int = random_number()
		print(word_list[current_int])
		s = 0
