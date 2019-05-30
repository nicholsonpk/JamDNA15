extends Node2D

var whereIsPlayer

var PLAYER_CAM_SPEED = 1700

var CAM_MAXX = 4815
var CAM_MINX = 3
var CAM_MAXY = 3
var CAM_MINY = -4809

var PLAY_MAXX = 5526
var PLAY_MINX = 87
var PLAY_MAXY = 716
var PLAY_MINY = -4720

enum runningOn { bottom, right, top, left }

var platformScene = preload("res://Platform.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	whereIsPlayer = runningOn.bottom
	get_node("KinematicBody2D/Player").global_position.x = PLAY_MINX
	get_node("KinematicBody2D/Player").global_position.y = PLAY_MAXY


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (whereIsPlayer == runningOn.bottom):
		
		# Move player and camera
		get_node("KinematicBody2D/Player").global_position.x += PLAYER_CAM_SPEED * delta
		get_node("KinematicBody2D/Camera2D").global_position.x += PLAYER_CAM_SPEED * delta
		
		# Limit camera movement 
		if (get_node("KinematicBody2D/Camera2D").global_position.x > CAM_MAXX):
			get_node("KinematicBody2D/Camera2D").global_position.x = CAM_MAXX
		
		# Player at edge, rotate
		if (get_node("KinematicBody2D/Player").global_position.x >= PLAY_MAXX):
			whereIsPlayer = runningOn.right
			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.right)
			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)
			get_node("KinematicBody2D/Player").global_position.x = PLAY_MAXX
			callSetUpPlatformsABunch()
	
	if (whereIsPlayer == runningOn.right):
		
		# Move player and camera
		get_node("KinematicBody2D/Player").global_position.y -= PLAYER_CAM_SPEED * delta
		get_node("KinematicBody2D/Camera2D").global_position.y -= PLAYER_CAM_SPEED * delta
		
		# Limit camera movement 
		if (get_node("KinematicBody2D/Camera2D").global_position.y < CAM_MINY):
			get_node("KinematicBody2D/Camera2D").global_position.y = CAM_MINY
		
		# Player at edge, rotate
		if (get_node("KinematicBody2D/Player").global_position.y <= PLAY_MINY):
			whereIsPlayer = runningOn.top
			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.top)
			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)
			get_node("KinematicBody2D/Player").global_position.y = PLAY_MINY
			callSetUpPlatformsABunch()
		
		
	if (whereIsPlayer == runningOn.top):
		
		# Move player and camera
		get_node("KinematicBody2D/Player").global_position.x -= PLAYER_CAM_SPEED * delta
		get_node("KinematicBody2D/Camera2D").global_position.x -= PLAYER_CAM_SPEED * delta
		
		# Limit camera movement 
		if (get_node("KinematicBody2D/Camera2D").global_position.x < CAM_MINX):
			get_node("KinematicBody2D/Camera2D").global_position.x = CAM_MINX
		
		# Player at edge, rotate
		if (get_node("KinematicBody2D/Player").global_position.x <= PLAY_MINX):
			whereIsPlayer = runningOn.left
			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.left)
			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)
			get_node("KinematicBody2D/Player").global_position.x = PLAY_MINX
			callSetUpPlatformsABunch()
		
		
		
	if (whereIsPlayer == runningOn.left):
		
		# Move player and camera
		get_node("KinematicBody2D/Player").global_position.y += PLAYER_CAM_SPEED * delta
		get_node("KinematicBody2D/Camera2D").global_position.y += PLAYER_CAM_SPEED * delta
		
		# Limit camera movement 
		if (get_node("KinematicBody2D/Camera2D").global_position.y > CAM_MAXY):
			get_node("KinematicBody2D/Camera2D").global_position.y = CAM_MAXY
		
		# Player at edge, rotate
		if (get_node("KinematicBody2D/Player").global_position.y >= PLAY_MAXY):
			whereIsPlayer = runningOn.bottom
			get_node("KinematicBody2D").setWhereIsPlayer(runningOn.bottom)
			get_node("KinematicBody2D/Player").rotate(-1.570796) # 90 degrees to Rads
			get_node("KinematicBody2D/CollisionShape2D").rotate(-1.570796)
			get_node("KinematicBody2D/Player").global_position.y = PLAY_MAXY
			callSetUpPlatformsABunch()


func getDirection():
	return whereIsPlayer

func callSetUpPlatformsABunch():
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()

func setUpPlatforms():
	randomize()
	
	if (whereIsPlayer == runningOn.bottom):
		var newX = rand_range(PLAY_MINX + 100, PLAY_MAXX - 343) # 100 + 243 platform width
		var newY = rand_range(PLAY_MAXY - 400, PLAY_MAXY - 22) # 22 is platform height
		var instacedScene = platformScene.instance()
		get_node("AllPlatforms").add_child(instacedScene)
		instacedScene.global_position.x = newX
		instacedScene.global_position.y = newY
		
	if (whereIsPlayer == runningOn.right):
		var newX = rand_range(PLAY_MAXX - 400, PLAY_MAXX - 22) # 100 + 243 platform width
		var newY = rand_range(PLAY_MINY + 100, PLAY_MAXY - 343) # 22 is platform height
		var instacedScene = platformScene.instance()
		get_node("AllPlatforms").add_child(instacedScene)
		instacedScene.rotate(-1.570796)
		instacedScene.global_position.x = newX
		instacedScene.global_position.y = newY
		
	if (whereIsPlayer == runningOn.top):
		var newX = rand_range(PLAY_MINX + 100, PLAY_MAXX - 343) # 100 + 243 platform width
		var newY = rand_range(PLAY_MINY + 400, PLAY_MINY + 22) # 22 is platform height
		var instacedScene = platformScene.instance()
		get_node("AllPlatforms").add_child(instacedScene)
		instacedScene.global_position.x = newX
		instacedScene.global_position.y = newY
		
	if (whereIsPlayer == runningOn.left):
		var newX = rand_range(PLAY_MINX + 22, PLAY_MINX + 400) # 100 + 243 platform width
		var newY = rand_range(PLAY_MINY + 100, PLAY_MAXY - 343) # 22 is platform height
		var instacedScene = platformScene.instance()
		get_node("AllPlatforms").add_child(instacedScene)
		instacedScene.rotate(1.570796)
		instacedScene.global_position.x = newX
		instacedScene.global_position.y = newY
