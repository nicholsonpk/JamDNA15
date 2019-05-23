extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		get_node("Player").global_position.x += 1000 * delta
	if Input.is_action_pressed("ui_left"):
		get_node("Player").global_position.x -= 1000 * delta
	
	if (get_node("Player").global_position.x >= 500):
		#begin tilt until 5600
		get_node("Player").rotate(-((9/20) * (700 - get_node("Player").global_position.x)))
