extends Node2D

var whereIsPlayer

var PLAYER_CAM_SPEED = 1000

var CAM_MAXX = 4815
var CAM_MINX = 3
var CAM_MAXY = 3
var CAM_MINY = -4809

var PLAY_MAXX = 5530
var PLAY_MINX = 80
var PLAY_MAXY = 715
var PLAY_MINY = -4720

enum runningOn { bottom, right, top, left }


# Called when the node enters the scene tree for the first time.
func _ready():
	whereIsPlayer = runningOn.bottom
	get_node("Player").global_position.x = PLAY_MINX
	get_node("Player").global_position.y = PLAY_MAXY


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (whereIsPlayer == runningOn.bottom):
		
		# Move player and camera
		get_node("Player").global_position.x += PLAYER_CAM_SPEED * delta
		get_node("Camera2D").global_position.x += PLAYER_CAM_SPEED * delta
		
		# Limit camera movement 
		if (get_node("Camera2D").global_position.x > CAM_MAXX):
			get_node("Camera2D").global_position.x = CAM_MAXX
		
		# Player at edge, rotate
		if (get_node("Player").global_position.x >= PLAY_MAXX):
			whereIsPlayer = runningOn.right
			get_node("Player").setWhereIsPlayer(runningOn.right)
			get_node("Player").rotate(-1.570796) # 90 degrees to Rads
	
	if (whereIsPlayer == runningOn.right):
		
		# Move player and camera
		get_node("Player").global_position.y -= PLAYER_CAM_SPEED * delta
		get_node("Camera2D").global_position.y -= PLAYER_CAM_SPEED * delta
		
		# Limit camera movement 
		if (get_node("Camera2D").global_position.y < CAM_MINY):
			get_node("Camera2D").global_position.y = CAM_MINY
		
		# Player at edge, rotate
		if (get_node("Player").global_position.y <= PLAY_MINY):
			whereIsPlayer = runningOn.top
			get_node("Player").setWhereIsPlayer(runningOn.top)
			get_node("Player").rotate(-1.570796) # 90 degrees to Rads
		
		
	if (whereIsPlayer == runningOn.top):
		
		# Move player and camera
		get_node("Player").global_position.x -= PLAYER_CAM_SPEED * delta
		get_node("Camera2D").global_position.x -= PLAYER_CAM_SPEED * delta
		
		# Limit camera movement 
		if (get_node("Camera2D").global_position.x < CAM_MINX):
			get_node("Camera2D").global_position.x = CAM_MINX
		
		# Player at edge, rotate
		if (get_node("Player").global_position.x <= PLAY_MINX):
			whereIsPlayer = runningOn.left
			get_node("Player").setWhereIsPlayer(runningOn.left)
			get_node("Player").rotate(-1.570796) # 90 degrees to Rads
		
		
		
	if (whereIsPlayer == runningOn.left):
		
		# Move player and camera
		get_node("Player").global_position.y += PLAYER_CAM_SPEED * delta
		get_node("Camera2D").global_position.y += PLAYER_CAM_SPEED * delta
		
		# Limit camera movement 
		if (get_node("Camera2D").global_position.y > CAM_MAXY):
			get_node("Camera2D").global_position.y = CAM_MAXY
		
		# Player at edge, rotate
		if (get_node("Player").global_position.y >= PLAY_MAXY):
			whereIsPlayer = runningOn.bottom
			get_node("Player").setWhereIsPlayer(runningOn.bottom)
			get_node("Player").rotate(-1.570796) # 90 degrees to Rads


func getDirection():
	return whereIsPlayer