extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED := 600

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	var velocity := Vector2()
	if (Input.is_action_pressed("ui_left")):
		velocity.x = -SPEED
	if(Input.is_action_pressed("ui_right")):
		velocity.x = SPEED
	if (Input.is_action_pressed("ui_up")):
		velocity.y = -SPEED
	if (Input.is_action_pressed("ui_down")):
		velocity.y = SPEED
		
	move_and_collide(velocity * delta)
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
