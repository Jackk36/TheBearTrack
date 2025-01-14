extends Sprite2D

var angular_speed: float = 1.0
var vertical_speed: float = 100.0
var moving_down: bool = true  # Tracks the movement direction
var screen_height: int

func _ready():
	# Get the screen height dynamically
	screen_height = 1200

func _process(delta):
	rotation += angular_speed * delta

	# Move the object up or down based on `moving_down`
	if moving_down:
		position.y += vertical_speed * delta
	else:
		position.y -= vertical_speed * delta

	# Reset position if it moves off-screen
	if position.y > screen_height:
		position.y = 0
	elif position.y < 0:
		position.y = screen_height

func _on_Sprite2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		moving_down = not moving_down
		print("Sprite clicked! Toggled moving down:", moving_down)
