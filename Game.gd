extends Node2D

enum runningOn { bottom, right, top, left }

var platformScene = preload("res://Platform.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	callSetUpPlatformsABunch()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func callSetUpPlatformsABunch():
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()
	setUpPlatforms()

func setUpPlatforms():
	randomize()

	var newX = rand_range(900, 1700)
	var newY = rand_range(200, 800)
	var instancedScene = platformScene.instance()
	get_node("AllPlatforms").add_child(instancedScene)
	instancedScene.global_position.x = newX
	instancedScene.global_position.y = newY
	instancedScene.add_to_group("platforms")
