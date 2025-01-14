extends Node2D

# Constants for grid dimensions
const ROWS = 6
const COLUMNS = 7
const EMPTY = 0
const RED = 1
const YELLOW = 2

# Variables
var grid = []
var current_player = RED

# Preload game piece scenes
@export var red_piece: PackedScene
@export var yellow_piece: PackedScene

func _ready():
	initialize_grid()
	draw_grid()

# Initialize the grid as a 2D array
func initialize_grid():
	grid = []
	for row in range(ROWS):
		grid.append([])
		for column in range(COLUMNS):
			grid[row].append(EMPTY)

# Draw the grid as a visual reference
func draw_grid():
	var grid_color = Color(0.2, 0.6, 1.0)
	var cell_size = 100

	for row in range(ROWS):
		for column in range(COLUMNS):
			var rect = Rect2(Vector2(column * cell_size, row * cell_size), Vector2(cell_size, cell_size))
			draw_rect(rect, grid_color, false, 3)

# Handle input to drop a piece
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var column = int(event.position.x / 100)
		if column >= 0 and column < COLUMNS:
			drop_piece(column)

# Drop a piece in the selected column
func drop_piece(column):
	for row in range(ROWS - 1, -1, -1):
		if grid[row][column] == EMPTY:
			grid[row][column] = current_player
			spawn_piece(row, column)
			if check_for_win(row, column):
				game_over()
			else:
				current_player = RED if current_player == YELLOW else YELLOW
			return

# Spawn a game piece in the scene
func spawn_piece(row, column):
	var piece = null
	if current_player == RED:
		piece = red_piece.instantiate()
	else:
		piece = yellow_piece.instantiate()
	add_child(piece)
	piece.position = Vector2(column * 100 + 50, row * 100 + 50)

# Check for a win condition
func check_for_win(row, column):
	return check_direction(row, column, 1, 0) or # Horizontal
		   check_direction(row, column, 0, 1) or # Vertical
		   check_direction(row, column, 1, 1) or # Diagonal (/)
		   check_direction(row, column, 1, -1)   # Diagonal (\)

# Check a specific direction for four in a row
func check_direction(row, column, delta_row, delta_column):
	var count = 1
	count += count_in_direction(row, column, delta_row, delta_column)
	count += count_in_direction(row, column, -delta_row, -delta_column)
	return count >= 4

# Count consecutive pieces in a direction
func count_in_direction(row, column, delta_row, delta_column):
	var count = 0
	var r = row + delta_row
	var c = column + delta_column

	while r >= 0 and r < ROWS and c >= 0 and c < COLUMNS and grid[r][c] == current_player:
		count += 1
		r += delta_row
		c += delta_column

	return count

# Handle game over
func game_over():
	print("Player", current_player, "wins!")
	get_tree().paused = true
