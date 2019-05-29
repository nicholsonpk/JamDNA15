extends KinematicBody2D

var isJumping = false
var isRunning = true
var isSliding = false
var isRolling = false

var slideRollTimer = 0

var whereIsPlayer

var JUMP_SPEED = -1200
var RUN_SPEED = 650
var GRAVITY = 2500

var velocity = Vector2()

var runningImage1 = preload("res://images/player_anim/Sprite-0001.png")
var runningImage2 = preload("res://images/player_anim/Sprite-0002.png")
var runningImage3 = preload("res://images/player_anim/Sprite-0003.png")
var runningImage4 = preload("res://images/player_anim/Sprite-0004.png")

var jumpingImage1 = preload("res://images/player_anim/Sprite-jump.png")

var slidingImage1 = preload("res://images/player_anim/Sprite-slide.png")

var rollingImage1 = preload("res://images/player_anim/Sprite-roll.png")

var currentFrame = 1
var timeSinceFrame = 0

enum runningOn { bottom, right, top, left }

# Set first running texture and player starts on the bottom.
func _ready():
	get_node("Player").set_texture(runningImage1)
	whereIsPlayer = runningOn.bottom

func get_input():
	
	# Clear before each pass
	isRunning = true
	
	var jump = Input.is_action_just_pressed('ui_up')
	var down = Input.is_action_just_pressed('ui_down')
	
	if (is_on_floor() or is_on_wall ()) and down:
		isSliding = true
		isJumping = false
		isRunning = false
	
	if (is_on_floor() or is_on_wall ()) and jump:
		isJumping = true
		isRunning = false
		isSliding = false
		isRolling = false
		
		if (whereIsPlayer == runningOn.bottom):
			velocity.y = JUMP_SPEED
		if (whereIsPlayer == runningOn.right):
			velocity.x = JUMP_SPEED
		if (whereIsPlayer == runningOn.top):
			velocity.y = -JUMP_SPEED
		if (whereIsPlayer == runningOn.left):
			velocity.x = -JUMP_SPEED
	
	# Always moving forward around the square
	if (whereIsPlayer == runningOn.bottom):
		velocity.x = RUN_SPEED
	if (whereIsPlayer == runningOn.right):
		velocity.y = -RUN_SPEED
	if (whereIsPlayer == runningOn.top):
		velocity.x = -RUN_SPEED
	if (whereIsPlayer == runningOn.left):
		velocity.y = RUN_SPEED

func _physics_process(delta):
	
	get_input()
	
	if (whereIsPlayer == runningOn.bottom):
		if (is_on_wall()):
			whereIsPlayer = runningOn.right
	
	# TO DO - fix ceiling collision
	if (whereIsPlayer == runningOn.right):
		if (is_on_ceiling()):
			whereIsPlayer = runningOn.top
	if (whereIsPlayer == runningOn.top):
		if (is_on_wall()):
			whereIsPlayer = runningOn.left
	if (whereIsPlayer == runningOn.left):
		if (is_on_floor()):
			whereIsPlayer = runningOn.bottom
	
	velocity = move_and_slide(velocity, Vector2(0, -1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if (whereIsPlayer == runningOn.bottom):
		velocity.y += GRAVITY * delta
	if (whereIsPlayer == runningOn.right):
		velocity.x += GRAVITY * delta
	if (whereIsPlayer == runningOn.top):
		velocity.y -= GRAVITY * delta
	if (whereIsPlayer == runningOn.left):
		velocity.x -= GRAVITY * delta

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
				get_node("Player").set_texture(runningImage1)
			if (currentFrame == 2):
				get_node("Player").set_texture(runningImage2)
			if (currentFrame == 3):
				get_node("Player").set_texture(runningImage3)
			if (currentFrame == 4):
				get_node("Player").set_texture(runningImage4)
				currentFrame = 1

		# Jumping
		if (isJumping):
			get_node("Player").set_texture(jumpingImage1)

		# Sliding
		if (isSliding && !isRolling):
			get_node("Player").set_texture(slidingImage1)

		# Rolling
		if (isRolling):
			get_node("Player").set_texture(rollingImage1)

		timeSinceFrame = 0

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

#
#
# Called by Game to keep player class in line with where the player is
#
#
func setWhereIsPlayer(var x):
	whereIsPlayer = x