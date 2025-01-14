extends Node2D

var angular_speed: float = 1.0
var vertical_speed: float = 100.0
var moving_down: bool = true  # Tracks the movement direction

func _process(delta):
	rotation += angular_speed * delta

	# Move the object up or down based on `moving_down`
	if moving_down:
		position.y += vertical_speed * delta
	else:
		position.y -= vertical_speed * delta

	# Reset position if it moves off-screen
	if position.y > 600:  # Adjust based on your screen height
		position.y = 0
	elif position.y < 0:  # Reset if moving up past the top
		position.y = 600

func _input(event):
	# Toggle the movement direction when the screen is clicked
	if event is InputEventMouseButton and event.pressed:
		moving_down = not moving_down
