extends Area2D

func _on_body_entered(_body):
	Stats.experience += 10
	queue_free()
