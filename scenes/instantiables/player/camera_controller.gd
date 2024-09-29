extends Camera3D

# Camera view limits.
const UPPER_LIMIT: float = 45
const LOWER_LIMIT: float = 60

# Chance sensitivity to constant later. 
@export_range(0, 1.00) var sensitivity: float = 0.01
@onready var camera_pivot = $".."

func _unhandled_input(event) -> void:
	# Lock the mouse.
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# Show the mouse. 
	elif event.is_action_pressed("show_cursor"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# Move camera.
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			# Rotate camera.
			camera_pivot.rotate_y(-event.relative.x * sensitivity)
			rotate_x(-event.relative.y * sensitivity)
			# Clamp camera vertical rotation. 
			rotation.x = clamp(rotation.x, deg_to_rad(LOWER_LIMIT * -1), deg_to_rad(UPPER_LIMIT))
