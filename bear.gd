extends RigidBody3D

const SPEED = 10.0
const JUMP_FORCE = 10.0
var can_jump = false
@export var sensitivity = 800

func _ready() -> void:
	# Enable continuous collision detection
	contact_monitor = true
	mass = 4.0


func _physics_process(delta: float) -> void:
	# Movement input
	var direction = Vector3.ZERO
	if get_contact_count() != 0:
		if Input.is_action_pressed("ui_right"):
			direction.z -= 1
		if Input.is_action_pressed("ui_left"):
			direction.z += 1
		if Input.is_action_pressed("ui_up"):
			direction.x -= 1
		if Input.is_action_pressed("ui_down"):
			direction.x += 1
	
	# Normalize direction for consistent movement
	if direction != Vector3.ZERO:
		direction = direction.normalized() * SPEED

	# Set horizontal linear velocity
	linear_velocity.x = direction.x
	linear_velocity.z = direction.z

	
	if Input.is_action_just_pressed("jump") and get_contact_count() != 0:
		linear_velocity.y = JUMP_FORCE
	


	#camera rotation
func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / sensitivity
		
		$CameraPivot.rotation.z -= event.relative.y / sensitivity
		$CameraPivot.rotation.z = clamp($CameraPivot.rotation.y, deg_to_rad(-20), deg_to_rad(20))
