extends Area2D

@onready var sprite = $Sprite2D
@onready var timer = $Timer
var player = preload("res://Characters/bunny.tscn")

@export var duration : int = 3

func _ready():
	sprite.visible = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("rebound"):
		timer.start(duration)
		sprite.visible = true
		var look = get_global_mouse_position()
		look_at(look)
	elif timer.is_stopped():
		sprite.visible = false
