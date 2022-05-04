extends KinematicBody2D

# Constant Variables
const Movement = preload("Movement.gd")
const BUTTON_UP = 0
const BUTTON_DOWN = 1
const BUTTON_LEFT = 0
const BUTTON_RIGHT = 1

# Onready Variables
onready var movement = Movement.new(speed, accel)
onready var most_recent_direction_button_y = BUTTON_UP
onready var most_recent_direction_button_x = BUTTON_LEFT

# Variables
var motion = Vector2()
export var speed = 400
export var accel = 40
export var decel = 400 #set decel = speed for instant stopping

# Classes
class Movement2:
	func thing():
		print("gamer")

# Only handles movement at the moment
# Collisions not working properly
func _physics_process(_delta):
	# Movement Y
	if Input.is_action_pressed("game_up") and Input.is_action_pressed("game_down"):
		if (most_recent_direction_button_y == BUTTON_DOWN):
			motion.y = movement.move(motion.y, 1)
		else:
			motion.y = movement.move(motion.y, -1)
	elif Input.is_action_pressed("game_up"):
		motion.y = movement.move(motion.y, -1)
	elif Input.is_action_pressed("game_down"):
		motion.y = movement.move(motion.y, 1)
	else:
		motion.y = movement.stop(motion.y)
	
	# Movement X
	if Input.is_action_pressed("game_right") and Input.is_action_pressed("game_left"):
		if (most_recent_direction_button_x == BUTTON_RIGHT):
			motion.x = movement.move(motion.x, 1)
		else:
			motion.x = movement.move(motion.x, -1)
	elif Input.is_action_pressed("game_left"):
		motion.x = movement.move(motion.x, -1)
	elif Input.is_action_pressed("game_right"):
		motion.x = movement.move(motion.x, 1)
	else:
		motion.x = movement.stop(motion.x)
	
	# Set Motion
	motion = move_and_slide(motion)


func _input(_event):
	var _a = 0
	# Keep track of most recently pressed movement button.
	if _event.is_action_pressed("game_up"):
		most_recent_direction_button_y = BUTTON_UP
	elif _event.is_action_pressed("game_left"):
		most_recent_direction_button_x = BUTTON_LEFT
	elif _event.is_action_pressed("game_down"):
		most_recent_direction_button_y = BUTTON_DOWN
	elif _event.is_action_pressed("game_right"):
		most_recent_direction_button_x = BUTTON_RIGHT
