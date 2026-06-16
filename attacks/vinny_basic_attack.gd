extends Area2D

var speed: int = 500
var direction
var attack_active: bool = false

func _ready():
	$SelfDestructTimer.start();

func _process(delta):
	position += direction * speed * delta
	var targets = get_tree().get_nodes_in_group("Enemies")
	for target in targets:
		if "hit" in target:
			target.hit()

func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()

func _on_self_destruct_timer_timeout():
	queue_free()
