extends Node2D

var isJumping = false
var finishedJump = false

var isSliding = false
var isRolling = false

var whereIsPlayer

var JUMP_SPEED = 300
var JUMP_HEIGHT = 100

var image1 = preload("res://images/player_anim/Sprite-0001.png")
var image2 = preload("res://images/player_anim/Sprite-0002.png")
var image3 = preload("res://images/player_anim/Sprite-0003.png")
var image4 = preload("res://images/player_anim/Sprite-0004.png")
var currentFrame = 1
var timeSinceFrame = 0

enum runningOn { bottom, right, top, left }

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(".").set_texture(image1)
	whereIsPlayer = runningOn.bottom

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	timeSinceFrame += delta
	if (timeSinceFrame >= .1):
		currentFrame += 1
		
		if (currentFrame == 1):
			get_node(".").set_texture(image1)
		if (currentFrame == 2):
			get_node(".").set_texture(image2)
		if (currentFrame == 3):
			get_node(".").set_texture(image3)
		if (currentFrame == 4):
			get_node(".").set_texture(image4)
			currentFrame = 1
		
		timeSinceFrame = 0
	
	if (isJumping == false  && isSliding == false && isRolling ==  false && Input.is_action_pressed("ui_up")):
		# jumping
		isJumping = true
	
	if (isJumping == false  && isSliding == false && isRolling ==  false && Input.is_action_pressed("ui_down")):
		# sliding
		isSliding = true

	if (isJumping):
		
		# bottom
		if (whereIsPlayer == runningOn.bottom):
			
			# move upward
			if (!finishedJump):
				get_node(".").global_position.y -= JUMP_SPEED * delta
				if (get_node(".").global_position.y <= 715 - JUMP_HEIGHT):
					finishedJump = true
			
			# drop down
			if (finishedJump):
				if (get_node(".").global_position.y <= 715):
					get_node(".").global_position.y += JUMP_SPEED * 2 * delta # fall twice as fast
				else:
					isJumping = false
					finishedJump = false
		
		# right
		if (whereIsPlayer == runningOn.right):
			
			if (!finishedJump):
				get_node(".").global_position.x -= JUMP_SPEED * delta
				if (get_node(".").global_position.x <= 5530 - JUMP_HEIGHT):
					finishedJump = true
			
			if (finishedJump):
				if (get_node(".").global_position.x <= 5530):
					get_node(".").global_position.x += JUMP_SPEED * 2 * delta # fall twice as fast
				else:
					isJumping = false
					finishedJump = false
		
		# top
		if (whereIsPlayer == runningOn.top):
			
			# move upward
			if (!finishedJump):
				get_node(".").global_position.y += JUMP_SPEED * delta
				if (get_node(".").global_position.y >= -4720 + JUMP_HEIGHT):
					finishedJump = true
			
			# drop down
			if (finishedJump):
				if (get_node(".").global_position.y >= -4720):
					get_node(".").global_position.y -= JUMP_SPEED * 2 * delta # fall twice as fast
				else:
					isJumping = false
					finishedJump = false
		
		# left
		if (whereIsPlayer == runningOn.left):
			
			# move upward
			if (!finishedJump):
				get_node(".").global_position.x += JUMP_SPEED * delta
				if (get_node(".").global_position.x >= 83 + JUMP_HEIGHT):
					finishedJump = true
			
			# drop down
			if (finishedJump):
				if (get_node(".").global_position.x >= 83):
					get_node(".").global_position.x -= JUMP_SPEED * 2 * delta # fall twice as fast
				else:
					isJumping = false
					finishedJump = false

func setWhereIsPlayer(var x):
	whereIsPlayer = x