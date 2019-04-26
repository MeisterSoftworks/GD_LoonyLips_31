extends Control

# Flavor for later
enum action_type{
	STAND, RIDE, CALL, VANGUARD, REARGUARD, GIFT, INTERCEPT
	}

var player_words = [] 
var current_story

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	set_current_story()
	DisplayText.text = ("Welcome to Loony Lips, a program inspired by the popular game MadLibs!!\n\n")
	check_PlayerWords_length()
	PlayerText.grab_focus()

func set_current_story():
	var stories = get_from_json("StoryBook.json")
	randomize()
	current_story = stories[randi() % stories.size()]
	
#	current_story = template[randi() % template.size()]

func get_from_json(filename):
	var filepath = "res://" + filename #user-suggested export fix
	var json_file = File.new()
	json_file.open(filepath, File.READ)
	
	var text = json_file.get_as_text() #instructs to read as text
	var data = parse_json(text)
	json_file.close()
	
	return data

func _on_PlayerText_text_entered(new_text):
	addto_PlayerWords()

func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		addto_PlayerWords()

func addto_PlayerWords():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	PlayerText.grab_focus()
	check_PlayerWords_length()

func is_story_done():
	return player_words.size() == current_story.prompts.size() #Check that player_words is same size as prompts.

func check_PlayerWords_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()

func tell_story():
	DisplayText.text = current_story.story % player_words

func prompt_player():
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + ", please?"

func end_game():
	PlayerText.queue_free()
	$VBoxContainer/HBoxContainer/Label.text = "Again!"
	tell_story()

