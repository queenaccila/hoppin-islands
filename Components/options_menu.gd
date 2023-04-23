extends Control

func _on_quit_pressed():
	$Sound.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Components/start_menu.tscn")
