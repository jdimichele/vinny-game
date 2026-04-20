extends CanvasLayer

@onready var player_level_label: Label = $PlayerLevel/VBoxContainer/Label
@onready var player_level_icon: TextureRect = $PlayerLevel/VBoxContainer/TextureRect
@onready var experience_label: Label = $Experience/VBoxContainer/Label
@onready var experience_icon: TextureRect = $Experience/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("stat_change", update_stat_text)

func update_stat_text():
	update_health_text()
	update_experience_text()
	update_player_level_text()

func update_health_text():
	health_bar.value = Globals.health

func update_experience_text():
	experience_label.text = str(Globals.experience)

func update_player_level_text():
	player_level_label.text = str(Globals.player_level)
