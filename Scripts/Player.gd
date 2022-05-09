extends KinematicBody2D

# Constant Variables
const BUTTON_UP = 0
const BUTTON_DOWN = 1
const BUTTON_LEFT = 0
const BUTTON_RIGHT = 1
const SQRT_H = sqrt(1.0/2.0)

# Onready Variables
onready var most_recent_direction_button_y = BUTTON_UP
onready var most_recent_direction_button_x = BUTTON_LEFT

# Variables
var motion = Vector2()
var velocity = Vector2()
var speed = 400
var accel = 1600    # "time to top speed" = speed / accel

# Only handles movement at the moment
func _physics_process(_delta):
	move(_delta)


func _input(_event):
	# Keep track of most recently pressed movement button.
	if _event.is_action_pressed("game_up"):
		most_recent_direction_button_y = BUTTON_UP
	elif _event.is_action_pressed("game_left"):
		most_recent_direction_button_x = BUTTON_LEFT
	elif _event.is_action_pressed("game_down"):
		most_recent_direction_button_y = BUTTON_DOWN
	elif _event.is_action_pressed("game_right"):
		most_recent_direction_button_x = BUTTON_RIGHT

# Gradually increase player speed up to speed using accel
func accelerate(vec, delta):
	# Accelerate x
	if (vec.x < 0):
		if (velocity.x > 0): # if velocity is positive while trying to move negative, set velocity to 0
			velocity.x = 0
		if (velocity.x > vec.x * speed):
			velocity.x -= accel * delta
	elif (vec.x > 0):
		if (velocity.x < 0): # if velocity is negative while trying to move positive, set velocity to 0
			velocity.x = 0
		if (velocity.x < vec.x * speed):
			velocity.x += accel * delta
	# Accelerate y
	if (vec.y < 0):
		if (velocity.y > 0): # if velocity is positive while trying to move negative, set velocity to 0
			velocity.y = 0
		if (velocity.y > vec.y * speed):
			velocity.y -= accel * delta
	elif (vec.y > 0):
		if (velocity.y < 0): # if velocity is negative while trying to move positive, set velocity to 0
			velocity.y = 0
		if (velocity.y < vec.y * speed):
			velocity.y += accel * delta
	
	# Deccelerate x
	if (abs(velocity.x) > abs(vec.x) * speed):
		velocity.x = vec.x * speed
	# Deccelerate y
	if (abs(velocity.y) > abs(vec.y) * speed):
		velocity.y = vec.y * speed

# Move the player based on input
func move(_delta):
	motion.x = -Input.get_action_strength("game_left") + Input.get_action_strength("game_right")
	motion.y = -Input.get_action_strength("game_up") + Input.get_action_strength("game_down")
	
	# Handle pressing perpendicular movement buttons
	# Set speed to sqrt(1/2) on both axis
	if (abs(motion.x) + abs(motion.y) == 2):
		if (motion.x == 1):
			motion.x = SQRT_H
		else:
			motion.x = -SQRT_H
		if (motion.y == 1):
			motion.y = SQRT_H
		else:
			motion.y = -SQRT_H
	
	# Handle pressing opposing directions at the same time
	# Use most recently pressed direction
	if Input.is_action_pressed("game_up") and Input.is_action_pressed("game_down"):
		if (most_recent_direction_button_y == BUTTON_DOWN):
			motion.y = 1
		else:
			motion.y = -1
	if Input.is_action_pressed("game_left") and Input.is_action_pressed("game_right"):
		if (most_recent_direction_button_x == BUTTON_RIGHT):
			motion.x = 1
		else:
			motion.x = -1
	
	if (Input.is_action_pressed("game_down") || Input.is_action_pressed("game_up") || Input.is_action_pressed("game_left") || Input.is_action_pressed("game_right")):
		accelerate(motion, _delta)
	else:
		velocity = motion * 0
	
	# Set Motion
	velocity = move_and_slide(velocity)
