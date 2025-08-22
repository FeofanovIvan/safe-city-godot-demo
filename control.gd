extends Control

@onready var youtube_button: TextureButton = $YouTubeKidsButton

func _ready():
	youtube_button.connect("pressed", _on_youtube_button_pressed)

func _on_youtube_button_pressed():
	OS.shell_open("https://www.youtubekids.com/")
