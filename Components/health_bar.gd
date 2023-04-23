extends Control

@onready var bar = $TextureProgressBar

func _on_health_updated(health, _amount):
		bar.value = health

func _on_max_health_updated(max_health):
		bar.max_value = max_health
