extends Sprite

# states of player
var isRunning = true
var isJumping = false
var finishedJump = false
var isSliding = false
var isRolling = false
var slideRollTimer = 0

var MAXY = 800

# 
var JUMP_SPEED = 600
var JUMP_HEIGHT = 200

# images for each animation
var runningImage1 = preload("res://images/player_anim/Sprite-0001.png")
var runningImage2 = preload("res://images/player_anim/Sprite-0002.png")
var runningImage3 = preload("res://images/player_anim/Sprite-0003.png")
var runningImage4 = preload("res://images/player_anim/Sprite-0004.png")

var jumpingImage1 = preload("res://images/player_anim/Sprite-jump.png")

var slidingImage1 = preload("res://images/player_anim/Sprite-slide.png")

var rollingImage1 = preload("res://images/player_anim/Sprite-roll.png")

var currentFrame = 1
var timeSinceFrame = 0



# Set first running texture and player starts on the bottom.
func _ready():
	set_texture(runningImage1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# Animations
	#
	#  .1 sets the framerate. Should match future animation speed
	#
	#

	timeSinceFrame += delta
	if (timeSinceFrame >= .1):
		currentFrame += 1

		# Running
		if (isRunning):
			if (currentFrame == 1):
				set_texture(runningImage1)
			if (currentFrame == 2):
				set_texture(runningImage2)
			if (currentFrame == 3):
				set_texture(runningImage3)
			if (currentFrame == 4):
				set_texture(runningImage4)
				currentFrame = 1

		# Jumping
		if (isJumping):
			set_texture(jumpingImage1)

		# Sliding
		if (isSliding && !isRolling):
			set_texture(slidingImage1)

		# Rolling
		if (isRolling):
			set_texture(rollingImage1)


		timeSinceFrame = 0


	#
	#
	# Check inputs
	#
	#

	# Neither input pressed
	if (!Input.is_action_pressed("ui_up") && !Input.is_action_pressed("ui_down") && !isJumping):
		isRunning = true

	# Up input pressed
	if (isJumping == false  && isSliding == false && isRolling ==  false && Input.is_action_pressed("ui_up")):
		# jumping
		isJumping = true

	# Down input pressed
	if (isJumping == false && isSliding == false && isRolling ==  false && Input.is_action_pressed("ui_down")):
		# sliding
		isSliding = true

	#
	# isRolling is set inside isSliding code
	#
	
	
	#
	#
	# Jumping
	#
	#

	if (isJumping):
		# move upward
		if (!finishedJump):
			global_position.y -= JUMP_SPEED * delta
			if (global_position.y <= MAXY - JUMP_HEIGHT):
				finishedJump = true
	
		# drop down
		if (finishedJump):
			# not a collision
			if (global_position.y <= MAXY):
				global_position.y += JUMP_SPEED * 2 * delta # fall twice as fast
			else: # is a collision
				isJumping = false
				finishedJump = false

	#
	#
	# Sliding and Rolling
	#
	#
	if (isSliding):

		# if the button is held down,
		# count length of time
		if (Input.is_action_pressed("ui_down")):
			isSliding = true
			slideRollTimer += delta
		else: # otherwise, reset timer and bools
			slideRollTimer = 0
			isSliding = false
			isRolling = false

		if (slideRollTimer > .5):
			# Rolling
			isRolling = true

#	# print to output for testing
#	var run
#	var jump
#	var slide
#	var roll
#	run = "true" if isRunning else "false"
#	jump = "true" if isJumping else "false"
#	slide = "true" if isSliding else "false"
#	roll = "true" if isRolling else "false"
#	print(run + jump + slide + roll)

#
#
# Check location vs all platforms
# to see if the player landed
#
#
#func notOnPlatform():
#
#	# find out where player is
#	var playerX = get_node("Player").global_position.x
#	var playerY = get_node("Player").global_position.y + 150
#	var playerXEnd = playerX + 75
#
#	var platforms = get_tree().get_nodes_in_group("platforms")
#	for N in platforms:
#
#		if (whereIsPlayer == runningOn.bottom):
#			# platform x = 243
#			# platform y = 22
#			var platformX = N.get_node("platformIndustrial_035").global_position.x
#			var platformY = N.get_node("platformIndustrial_035").global_position.y
#			var platformXEnd = platformX + 243
#
#			if (playerXEnd >= platformX &&
#				playerX <= platformXEnd && 
#				playerY >= platformY && 
#				playerY <= platformY + 5):
#				# collision
#				return false
#
#	return true