extends CanvasLayer

@onready var player_level_label: Label = $PlayerLevel/VBoxContainer/Label
@onready var player_level_icon: TextureRect = $PlayerLevel/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $HealthProgressContainer/HealthProgressBar
@onready var experience_bar: TextureProgressBar = $ExperienceProgressContainer/ExperienceProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("stat_change", update_stat_text)

func update_stat_text():
	update_health_bar()
	update_experience_bar()
	update_player_level_text()

func update_health_bar():
	health_bar.value = Globals.health

func update_max_health():
	health_bar.max_value = Globals.max_health

func update_experience_bar():
	experience_bar.value = Globals.experience

func update_player_level_text():
	player_level_label.text = str(Globals.player_level)
