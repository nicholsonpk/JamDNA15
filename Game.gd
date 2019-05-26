extends Node2D

var whereIsPlayer

var PLAYER_CAM_SPEED = 350

var CAM_MAXX = 4815
var CAM_MINX = 3
var CAM_MAXY = 3
var CAM_MINY = -4809

var PLAY_MAXX = 5527
var PLAY_MINX = 83
var PLAY_MAXY = 712
var PLAY_MINY = -4717

enum runningOn { bottom, right, top, left }


# Called when the node enters the scene tree for the first time.
func _ready():
	whereIsPlayer = runningOn.bottom
	get_node("KinematicBody2D/Player").global_position.x = PLAY_MINX
	get_node("KinematicBody2D/Player").global_position.y = PLAY_MAXY


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if (whereIsPlayer == runningOn.bottom):
#
#		# Move player and camera
#		get_node("KinematicBody2D/Player").global_position.x += PLAYER_CAM_SPEED * delta
#		get_node("Camera2D").global_position.x += PLAYER_CAM_SPEED * delta
#
#		# Limit camera movement 
#		if (get_node("Camera2D").global_position.x > CAM_MAXX):
#			get_node("Camera2D").global_position.x = CAM_MAXX
#
#		# Player at edge, rotate
#		if (get_node("KinematicBody2D/Player").global_position.x >= PLAY_MAXX):
#			whereIsPlayer = runningOn.right
#			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.right)
#			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
#			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)
#
#	if (whereIsPlayer == runningOn.right):
#
#		# Move player and camera
#		get_node("KinematicBody2D/Player").global_position.y -= PLAYER_CAM_SPEED * delta
#		get_node("Camera2D").global_position.y -= PLAYER_CAM_SPEED * delta
#
#		# Limit camera movement 
#		if (get_node("Camera2D").global_position.y < CAM_MINY):
#			get_node("Camera2D").global_position.y = CAM_MINY
#
#		# Player at edge, rotate
#		if (get_node("KinematicBody2D/Player").global_position.y <= PLAY_MINY):
#			whereIsPlayer = runningOn.top
#			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.top)
#			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
#			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)
#
#
#	if (whereIsPlayer == runningOn.top):
#
#		# Move player and camera
#		get_node("KinematicBody2D/Player").global_position.x -= PLAYER_CAM_SPEED * delta
#		get_node("Camera2D").global_position.x -= PLAYER_CAM_SPEED * delta
#
#		# Limit camera movement 
#		if (get_node("Camera2D").global_position.x < CAM_MINX):
#			get_node("Camera2D").global_position.x = CAM_MINX
#
#		# Player at edge, rotate
#		if (get_node("KinematicBody2D/Player").global_position.x <= PLAY_MINX):
#			whereIsPlayer = runningOn.left
#			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.left)
#			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
#			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)
#
#
#
#	if (whereIsPlayer == runningOn.left):
#
#		# Move player and camera
#		get_node("KinematicBody2D/Player").global_position.y += PLAYER_CAM_SPEED * delta
#		get_node("Camera2D").global_position.y += PLAYER_CAM_SPEED * delta
#
#		# Limit camera movement 
#		if (get_node("Camera2D").global_position.y > CAM_MAXY):
#			get_node("Camera2D").global_position.y = CAM_MAXY
#
#		# Player at edge, rotate
#		if (get_node("KinematicBody2D/Player").global_position.y >= PLAY_MAXY):
#			whereIsPlayer = runningOn.bottom
#			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.bottom)
#			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
#			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)


func getDirection():
	return whereIsPlayer