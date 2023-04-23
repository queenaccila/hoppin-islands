extends Control

func _on_start_pressed():
	$VBoxContainer/Click.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")


func _on_quit_pressed():
	$VBoxContainer/Click.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()


func _on_options_pressed():
	$VBoxContainer/Click.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Components/options_menu.tscn")
