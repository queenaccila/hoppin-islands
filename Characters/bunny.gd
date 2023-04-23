extends CharacterBody2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var raycast = $Raycast2D
#var bee_enemy = preload("res://Characters/bee.tscn")

#player adjustments
@export var speed : int = 100
@export var jump : float = -10
@export var wall_climb : float = -10
@export var gravity : int = 10

# jump variables for double jump
var jump_max = 2
var jump_count = 0

# wall slide for animation
var wall_slide : bool = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# jump trigger
	if jump_count < jump_max:
		if Input.is_action_just_pressed("jump"):
			velocity.y += jump
			jump_count += 1

	var direction = Input.get_axis("left", "right")
	var input_direction = Vector2(direction, velocity.y)
	
	# jump velocity
	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if is_on_floor() and jump_count != 0:
		jump_count = 0
	
	# flip sprite
	if(direction < 0):
		sprite.flip_h = true
		raycast.scale.x = -1
	elif(direction > 0):
		sprite.flip_h = false
		raycast.scale.x = 1
	
	# wall climbing
	if Input.is_action_just_pressed("climb") and next_to_wall():
		if raycast.get_collider().name == "TileMap":
			jump_max = 10
			velocity.y += wall_climb
		else:
			jump_max = 2
			velocity.y = 0
	
	update_animation_parameters(input_direction)
	move_and_slide()
	move_and_collide(input_direction)
	pick_new_state()

# wall climb detection
func next_to_wall():
	return next_right_wall()
# right wall climb detection
func next_right_wall():
	return $Raycast2D.is_colliding()

func update_animation_parameters(move_input: Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/walk/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)

func pick_new_state():
	if(velocity.x != 0 and is_on_floor()):
		state_machine.travel("walk")
	elif(velocity.y != 0 and not is_on_floor()):
		state_machine.travel("jump")
	elif(wall_slide == true):
		state_machine.travel("climb")
	else:
		state_machine.travel("idle")
