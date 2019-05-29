extends Node2D

var whereIsPlayer

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
	set_process(true)


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (whereIsPlayer == runningOn.bottom):
		# Limit camera movement 
		if (get_node("KinematicBody2D/Camera2D").global_position.x > CAM_MAXX):
			get_node("KinematicBody2D/Camera2D").global_position.x = CAM_MAXX

#		# Player at edge, rotate
		if (get_node("KinematicBody2D/Player").global_position.x >= PLAY_MAXX):
			whereIsPlayer = runningOn.right
#			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.right)
#			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
#			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)

	if (whereIsPlayer == runningOn.right):
		# Limit camera movement 
		if (get_node("KinematicBody2D/Camera2D").global_position.y < CAM_MINY):
			get_node("KinematicBody2D/Camera2D").global_position.y = CAM_MINY

#		# Player at edge, rotate
		if (get_node("KinematicBody2D/Player").global_position.y <= PLAY_MINY):
			whereIsPlayer = runningOn.top
#			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.top)
#			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
#			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)

	if (whereIsPlayer == runningOn.top):

		# Limit camera movement 
		if (get_node("KinematicBody2D/Camera2D").global_position.x < CAM_MINX):
			get_node("KinematicBody2D/Camera2D").global_position.x = CAM_MINX

#		# Player at edge, rotate
		if (get_node("KinematicBody2D/Player").global_position.x <= PLAY_MINX):
			whereIsPlayer = runningOn.left
#			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.left)
#			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
#			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)

	if (whereIsPlayer == runningOn.left):
		
		# Limit camera movement 
		if (get_node("KinematicBody2D/Camera2D").global_position.y > CAM_MAXY):
			get_node("KinematicBody2D/Camera2D").global_position.y = CAM_MAXY

#		# Player at edge, rotate
		if (get_node("KinematicBody2D/Player").global_position.y >= PLAY_MAXY):
			whereIsPlayer = runningOn.bottom
#			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.bottom)
#			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
#			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)


func getDirection():
	return whereIsPlayer