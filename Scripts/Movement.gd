extends Node

class_name Movement

# Member variables
var max_speed
var accel
var dir


var speed_vec
var diag_max_speed

var speed
var decel


func _ready():
	max_speed = 100
	speed_vec = Vector2(0, 0)

















# accelerate up to speed
# take current speed, add speed unless at or above max speed
# take in direction multiplier, a positive number for a positive direction, negative number for a negative direction
func move(current_speed, direction):
	# if current speed is opposite the acceleration direction, stop() instead
	if current_speed * direction < 0:
		return stop(current_speed)
	
	current_speed += accel * direction
	
	# limit max speed
	if abs(current_speed) > speed:
		if direction > 0:
			return speed
		if direction < 0:
			return -speed
	
	return current_speed

# decelerate down to 0
# take current speed, 
func stop(current_speed):
	# if decel = speed, instantaneously stop the motion
	# if current_speed is already 0, keep the motion stopped
	if decel == speed or current_speed == 0:
		return 0
	#if current speed is negative, add decel until at or above 0
	elif current_speed < 0:
		current_speed += decel
		if current_speed > 0:
			current_speed = 0
		return current_speed
	#if current speed is positive, add decel until at or below 0
	else:
		current_speed -= decel
		if current_speed < 0:
			current_speed = 0
		return current_speed

# set the rate of deceleration
func set_decel(_decel):
	decel = _decel

func current_speed(x, y):
	pass

# Constructor
# decel = speed unless set otherwise with set_decel()
# - this results in instantaneous stopping
func _init(_speed, _accel):
	speed = _speed
	accel = _accel
	decel = speed
