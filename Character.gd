extends KinematicBody

var gravity = -9.8
var velocity = Vector3()
var camera
var character
var jump_height = 4

const SPEED = 10
const ACCELERATION = 3
const DE_ACCELERATION = 5

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	character = get_node(".")
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	
	camera = get_node("Target/Camera").get_global_transform()
	var dir = Vector3()
	
	var is_moving = false

	if(Input.is_action_pressed("forward")):
		dir += -camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("backward")):
		dir += camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("left")):
		dir += -camera.basis[0]
		is_moving = true
	if(Input.is_action_pressed("right")):
		dir += camera.basis[0]
		is_moving = true
	
	if(Input.is_action_pressed("jump")) and is_on_floor():
		velocity.y = jump_height
	
		
	dir.y = 0
	dir = dir.normalized()
	
	velocity.y += delta * gravity
	
	var hv = velocity
	hv.y = 0
	
	var new_pos = dir * SPEED
	var accel = DE_ACCELERATION
	
	if (dir.dot(hv) > 0):
		accel = ACCELERATION
		
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
			
	velocity = move_and_slide(velocity, Vector3(0,1,0))	
	
	if is_moving:
		
		# Rotate the player to direction
		var angle = atan2(hv.x, hv.z)
		
		var char_rot = character.get_rotation()
		
		char_rot.y = angle
		character.set_rotation(char_rot)
	
	
