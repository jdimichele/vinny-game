extends Area2D

var speed: int = 2
var direction

func _ready():
	$SelfDestructTimer.start();

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()

func _on_self_destruct_timer_timeout():
	queue_free()
