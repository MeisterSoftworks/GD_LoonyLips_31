extends Control

func _ready():
	var prompts = ["flightless bird", "winging it", "roosters", "cocks"]
	var story = "Once there was a giant %s. He was always being encouraged to try but he just got tired of %s. This banter didn't go over well with the %s, but what could he expect from a bunch of %s!"
	
	$VBoxContainer/DisplayText.text = story % prompts

func _on_PlayerText_text_entered(new_text):
	update_DisplayText(new_text)

func update_DisplayText(words):
	$VBoxContainer/DisplayText.text = words
	$VBoxContainer/PlayerText.clear()
