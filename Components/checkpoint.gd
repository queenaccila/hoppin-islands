extends Area2D

var check = false

func _on_body_entered(_body):
	check = true

func _on_body_exited(_body):
	check = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("confirm") and check == true:
		get_tree().change_scene_to_file("res://Components/start_menu.tscn")
