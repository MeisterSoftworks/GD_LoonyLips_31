extends Control

var player_words = []
var prompts = ["an animal", "a verb", "a noun", "a plural noun"]
var story = "Once there was a giant %s. He was always being encouraged to try but he just got tired of %s. This banter didn't go over well with the %s, but what could he expect from a bunch of %s!"

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	DisplayText.text = ("Welcome to Loony Lips, a program inspired by the popular game MadLibs!!\n\n")
	check_PlayerWords_length()

func _on_PlayerText_text_entered(new_text):
	addto_PlayerWords()

func _on_TextureButton_pressed():
	addto_PlayerWords()

func addto_PlayerWords():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	PlayerText.grab_focus()
	check_PlayerWords_length()

func is_story_done():
	return player_words.size() == prompts.size() #Check that player_words is same size as prompts.

func check_PlayerWords_length():
	if is_story_done():
		tell_story()
	else:
		prompt_player()

func tell_story():
	DisplayText.text = story % player_words

func prompt_player():
	DisplayText.text += "May I have " + prompts[player_words.size()] + ", please?"
