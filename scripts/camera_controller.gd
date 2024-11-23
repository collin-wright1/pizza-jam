extends Camera2D

var dragging = false
var original_pos
var zoom_mult = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("move_camera"):
		pass
		
		
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_camera"):
		dragging = true
		#original_pos = get_global_mouse_position()
		original_pos = get_global_mouse_position()
	if Input.is_action_just_released("move_camera"):
		dragging = false
	
	if dragging and event is InputEventMouseMotion:
		#position += original_pos - get_global_mouse_position()
		position += original_pos - get_global_mouse_position()
	if Input.is_action_just_pressed("zoom_in"):
		zoom_in()
	if Input.is_action_just_pressed("zoom_out"):
		zoom_out()



func zoom_in():
	zoom += Vector2(0.1,0.1)
	
	zoom_mult -= 0.1
	if zoom.x >= 2.1:
		zoom = Vector2(2.0,2.0)
	

func zoom_out():
	zoom -= Vector2(0.1,0.1)
	zoom_mult += 0.3
	if zoom.x <= 0.2:
		zoom = Vector2(0.3,0.3)
