extends Node2D



@onready var static_body_2d: StaticBody2D = $StaticBody2D
@onready var visual_selection: TileMapLayer = $VisualSelection
@onready var rotate_holder: Node2D = $RotateHolder
@onready var anim: AnimationPlayer = $AnimationPlayer



var is_rotating : bool = false

var current_rotation

func _process(delta: float) -> void:
	if is_rotating:
		#look_at(get_global_mouse_position())
		#rotation_degrees = snapped(rotation_degrees,60)
		pass



func _input(event: InputEvent) -> void:
	
	if visible:
		if event is InputEventMouseButton and is_rotating:
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
				is_rotating = false
				print(is_rotating)
				
		#if Input.is_action_just_pressed("rotate_left"):
			#current_rotation = rotate_left()
		#if Input.is_action_just_pressed("rotate_right"):
			#current_rotation =rotate_right()
		#if Input.is_action_just_pressed("ui_accept"):
			#get_parent().apply_rotation(current_rotation)

func _on_static_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			is_rotating = true
			print(is_rotating)
			
			
func rotate_left() -> Array:
	rotate_holder.rotation_degrees -= 60
	var surrounding_tiles = [Vector2i(0,-1),Vector2i(1,-1),Vector2i(1,0),Vector2i(0,1),Vector2i(-1,0),Vector2i(-1,-1)]
	var original_tiles = []
	for vector in surrounding_tiles:
		original_tiles.append(visual_selection.get_cell_alternative_tile(vector))
	original_tiles.push_back(original_tiles.pop_at(0))
	var count = 0
	for vector in surrounding_tiles:
		visual_selection.set_cell(vector,1,Vector2i.ZERO,original_tiles[count])
		count +=1
	return	original_tiles
	
	
func rotate_right() -> Array:
	rotate_holder.rotation_degrees += 60
	var surrounding_tiles = [Vector2i(0,-1),Vector2i(1,-1),Vector2i(1,0),Vector2i(0,1),Vector2i(-1,0),Vector2i(-1,-1)]
	var original_tiles = []
	for vector in surrounding_tiles:
		original_tiles.append(visual_selection.get_cell_atlas_coords(vector))
	original_tiles.push_front(original_tiles.pop_at(-1))
	var count = 0
	for vector in surrounding_tiles:
		visual_selection.set_cell(vector,1,original_tiles[count],0)
		count +=1
	get_parent().apply_rotation(original_tiles)
	$AnimationPlayer.play("lower_down", -1, 2)
	return	original_tiles
	
	
