extends KinematicBody2D

# Constant Variables
const Movement = preload("Movement.gd")

# Onready Variables
onready var movement = Movement.new(speed, accel)

# Variables
var motion = Vector2()
export var speed = 300
export var accel = 40
export var decel = 300 #set decel = speed for instant stopping


# Only handles movement at the moment
# Collisions not working properly
# BUG: upon switching between opposite directions within one frame of each other, movement.stop() is skipped
#      resulting in reverse acceleration, rather than deceleration
#      - consider calling movement.stop() during movement.move() if current speed is opposite current acceleration
func _physics_process(delta):
	
	if Input.is_action_pressed("game_up") and Input.is_action_pressed("game_down"):
		motion.y = movement.stop(motion.y)
	elif Input.is_action_pressed("game_down"):
		motion.y = movement.move(motion.y, 1)
	elif Input.is_action_pressed("game_up"):
		motion.y = movement.move(motion.y, -1)
	else:
		motion.y = movement.stop(motion.y)
	
	if Input.is_action_pressed("game_left") and Input.is_action_pressed("game_right"):
		motion.x = movement.stop(motion.x)
	elif Input.is_action_pressed("game_right"):
		motion.x = movement.move(motion.x, 1)
	elif Input.is_action_pressed("game_left"):
		motion.x = movement.move(motion.x, -1)
	else:
		motion.x = movement.stop(motion.x)
	
	motion = move_and_slide(motion)


func _input(event):
	var a = 0
