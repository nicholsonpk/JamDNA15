# Depricated 
# Code moved to KinematicBody2D for
# collision detection



#extends Node2D
#
#var isJumping = false
#var finishedJump = false
#
#var isSliding = false
#var isRolling = false
#var slideRollTimer = 0
#
#var isRunning = true
#
#var whereIsPlayer
#
#var JUMP_SPEED = 600
#var JUMP_HEIGHT = 300
#
#var runningImage1 = preload("res://images/player_anim/Sprite-0001.png")
#var runningImage2 = preload("res://images/player_anim/Sprite-0002.png")
#var runningImage3 = preload("res://images/player_anim/Sprite-0003.png")
#var runningImage4 = preload("res://images/player_anim/Sprite-0004.png")
#
#var slidingImage1 = preload("res://images/player_anim/Sprite-slide.png")
#
#var rollingImage1 = preload("res://images/player_anim/Sprite-roll.png")
#
#var currentFrame = 1
#var timeSinceFrame = 0
#
#enum runningOn { bottom, right, top, left }
#
## Set first running texture and player starts on the bottom.
#func _ready():
#	get_node(".").set_texture(runningImage1)
#	whereIsPlayer = runningOn.bottom
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#
#	# Animations
#	#
#	#  .1 sets the framerate. Should match future animation speed
#	# 
#	#
#
#	timeSinceFrame += delta
#	if (timeSinceFrame >= .1):
#		currentFrame += 1
#
#		# Running
#		if (isRunning):
#			if (currentFrame == 1):
#				get_node(".").set_texture(runningImage1)
#			if (currentFrame == 2):
#				get_node(".").set_texture(runningImage2)
#			if (currentFrame == 3):
#				get_node(".").set_texture(runningImage3)
#			if (currentFrame == 4):
#				get_node(".").set_texture(runningImage4)
#				currentFrame = 1
#
#		# Jumping
##		if (isJumping):
##			get_node(".").set_texture(jumpingImage1)
#
#		# Sliding
#		if (isSliding && !isRolling):
#			get_node(".").set_texture(slidingImage1)
#
#		# Rolling
#		if (isRolling):
#			get_node(".").set_texture(rollingImage1)
#
#
#		timeSinceFrame = 0
#
#
#	#
#	#
#	# Check inputs
#	#
#	#
#
#	# Neither input pressed
#	if (!Input.is_action_pressed("ui_up") && !Input.is_action_pressed("ui_down") && !isJumping):
#		isRunning = true
#
#	# Up input pressed
#	if (isJumping == false  && isSliding == false && isRolling ==  false && Input.is_action_pressed("ui_up")):
#		# jumping
#		isJumping = true
#
#	# Down input pressed
#	if (isJumping == false && isSliding == false && isRolling ==  false && Input.is_action_pressed("ui_down")):
#		# sliding
#		isSliding = true
#
#	#
#	# isRolling is set inside isSliding code
#	#
#
#	#
#	#
#	# Jumping
#	#
#	#
#
#	if (isJumping):
#
#		# bottom
#		if (whereIsPlayer == runningOn.bottom):
#
#			# move upward
#			if (!finishedJump):
#				get_node(".").global_position.y -= JUMP_SPEED * delta
#				if (get_node(".").global_position.y <= 715 - JUMP_HEIGHT):
#					finishedJump = true
#
#			# drop down
#			if (finishedJump):
#				if (get_node(".").global_position.y <= 715):
#					get_node(".").global_position.y += JUMP_SPEED * 2 * delta # fall twice as fast
#				else:
#					isJumping = false
#					finishedJump = false
#
#		# right
#		if (whereIsPlayer == runningOn.right):
#
#			if (!finishedJump):
#				get_node(".").global_position.x -= JUMP_SPEED * delta
#				if (get_node(".").global_position.x <= 5530 - JUMP_HEIGHT):
#					finishedJump = true
#
#			if (finishedJump):
#				if (get_node(".").global_position.x <= 5530):
#					get_node(".").global_position.x += JUMP_SPEED * 2 * delta # fall twice as fast
#				else:
#					isJumping = false
#					finishedJump = false
#
#		# top
#		if (whereIsPlayer == runningOn.top):
#
#			# move upward
#			if (!finishedJump):
#				get_node(".").global_position.y += JUMP_SPEED * delta
#				if (get_node(".").global_position.y >= -4720 + JUMP_HEIGHT):
#					finishedJump = true
#
#			# drop down
#			if (finishedJump):
#				if (get_node(".").global_position.y >= -4720):
#					get_node(".").global_position.y -= JUMP_SPEED * 2 * delta # fall twice as fast
#				else:
#					isJumping = false
#					finishedJump = false
#
#		# left
#		if (whereIsPlayer == runningOn.left):
#
#			# move upward
#			if (!finishedJump):
#				get_node(".").global_position.x += JUMP_SPEED * delta
#				if (get_node(".").global_position.x >= 83 + JUMP_HEIGHT):
#					finishedJump = true
#
#			# drop down
#			if (finishedJump):
#				if (get_node(".").global_position.x >= 83):
#					get_node(".").global_position.x -= JUMP_SPEED * 2 * delta # fall twice as fast
#				else:
#					isJumping = false
#					finishedJump = false
#
#	#
#	#
#	# Sliding and Rolling
#	#
#	#
#	if (isSliding):
#
#		# if the button is held down,
#		# count length of time
#		if (Input.is_action_pressed("ui_down")):
#			isSliding = true
#			slideRollTimer += delta
#		else: # otherwise, reset timer and bools
#			slideRollTimer = 0
#			isSliding = false
#			isRolling = false
#
#		if (slideRollTimer > .5):
#			# Rolling
#			isRolling = true
#
##	# print to output for testing
##	var run
##	var jump
##	var slide
##	var roll
##	run = "true" if isRunning else "false"
##	jump = "true" if isJumping else "false"
##	slide = "true" if isSliding else "false"
##	roll = "true" if isRolling else "false"
##	print(run + jump + slide + roll)
#
##
##
## Called by Game to keep player class in line with where the player is
##
##
#func setWhereIsPlayer(var x):
#	whereIsPlayer = x