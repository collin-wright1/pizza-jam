extends Node2D

@onready var map: TileMapLayer = $TileMapLayer
@onready var visual_map: TileMapLayer = $Visualmap/VisualSelection


var selected_tile

enum game_states{
	picking,
	rotating
}
var game_state = game_states.picking

func _physics_process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	
	match game_state:
		game_states.picking:
			if event is InputEventMouseButton:
				if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
					game_state = game_states.rotating
					$Visualmap.get_node("AnimationPlayer").play("raise_up")
					visual_map.show()
					var clicked_tile = map.local_to_map(get_global_mouse_position())
					selected_tile = clicked_tile
					visual_map.get_parent().position = map.map_to_local(Vector2(clicked_tile.x,clicked_tile.y))
					
					
					#print(map.local_to_map(get_global_mouse_position()))
					#print(visual_map.local_to_map(get_global_mouse_position()))
					var surrounding_tile = Vector2i(clicked_tile)
					if clicked_tile.x % 2 == 0:
						#center,t,tr,br,b,bl,tl
						
						visual_map.clear()
						#center
						visual_map.set_cell(Vector2i.ZERO,1,Vector2i.ZERO,map.get_cell_alternative_tile(clicked_tile))		
						
						#t
						surrounding_tile = (Vector2i(clicked_tile.x,clicked_tile.y-1))
						visual_map.set_cell(surrounding_tile - clicked_tile,1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))			
						#tr
						surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y-1))
						visual_map.set_cell(surrounding_tile-clicked_tile,1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))	
						#br
						surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y))
						visual_map.set_cell(surrounding_tile-clicked_tile,1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))	
						#b
						surrounding_tile=(Vector2i(clicked_tile.x,clicked_tile.y+1))
						visual_map.set_cell(surrounding_tile-clicked_tile,1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))	
						#bl
						surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y))
						visual_map.set_cell(surrounding_tile-clicked_tile,1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))	
						#tl
						surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y-1))
						visual_map.set_cell(surrounding_tile-clicked_tile,1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))	
						
						#var tile_coords = []
						#for vector in surrounding_tiles:
							#tile_coords.append(map.get_cell_alternative_tile(vector))
						#visual_map.clear()
						#print(tile_coords)
						#for coord in tile_coords.size():	
						
							
							#visual_map.set_cell(Vector2i(surrounding_tiles[0])-Vector2i(surrounding_tiles[coord]),1,Vector2i.ZERO,tile_coords[coord])		
							
						#$visualmap.scale= 1.5
						#visual_map.set_cell(Vector2(-5,-5),0,Vector2i(0,0))	
						
						
					else:
						visual_map.clear()
						#center
						visual_map.set_cell(Vector2i.ZERO,1,Vector2i.ZERO,map.get_cell_alternative_tile(clicked_tile))		
						
						#t
						surrounding_tile = (Vector2i(clicked_tile.x,clicked_tile.y-1))
						visual_map.set_cell(surrounding_tile - clicked_tile,1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))			
						#tr
						surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y))
						visual_map.set_cell(Vector2i(surrounding_tile.x-clicked_tile.x,surrounding_tile.y-clicked_tile.y-1),1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))	
						#br
						surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y+1))
						visual_map.set_cell(Vector2i(surrounding_tile.x-clicked_tile.x,surrounding_tile.y-clicked_tile.y-1),1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))	
						#b
						surrounding_tile=(Vector2i(clicked_tile.x,clicked_tile.y+1))
						visual_map.set_cell(surrounding_tile-clicked_tile,1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))	
						#bl
						surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y+1))
						visual_map.set_cell(Vector2i(surrounding_tile.x-clicked_tile.x,surrounding_tile.y-clicked_tile.y-1),1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))	
						#tl
						surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y))
						visual_map.set_cell(Vector2i(surrounding_tile.x-clicked_tile.x,surrounding_tile.y-clicked_tile.y-1),1,Vector2i.ZERO,map.get_cell_alternative_tile(surrounding_tile))
					
					
			
		game_states.rotating:
			if event is InputEventMouseButton:
				if event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
					game_state = game_states.picking
					$Visualmap.get_node("AnimationPlayer").play("lower_down")
					#visual_map.hide()
		
		
func apply_rotation(new_tile_array):
	
	print(selected_tile)
	print(new_tile_array)
	
	if selected_tile.x % 2 == 0:
		#surrounding_tile = (Vector2i(selected_tile.x,selected_tile.y-1))
		map.set_cell(Vector2i(selected_tile.x,selected_tile.y-1),2,Vector2i.ZERO,new_tile_array[0])		
		#tr
		#surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y-1))
		map.set_cell(Vector2i(selected_tile.x+1,selected_tile.y-1),2,Vector2i.ZERO,new_tile_array[1])	
		#br
		#surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y))
		map.set_cell(Vector2i(selected_tile.x+1,selected_tile.y),2,Vector2i.ZERO,new_tile_array[2])	
		#b
		#surrounding_tile=(Vector2i(clicked_tile.x,clicked_tile.y+1))
		map.set_cell(Vector2i(selected_tile.x,selected_tile.y+1),2,Vector2i.ZERO,new_tile_array[3])		#bl
		#surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y))
		map.set_cell(Vector2i(selected_tile.x-1,selected_tile.y),2,Vector2i.ZERO,new_tile_array[4])	
		#tl
		#surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y-1))
		map.set_cell(Vector2i(selected_tile.x-1,selected_tile.y-1),2,Vector2i.ZERO,new_tile_array[5])	
	else:					
		#t
		#surrounding_tile = (Vector2i(clicked_tile.x,clicked_tile.y-1))
		map.set_cell(Vector2i(selected_tile.x,selected_tile.y-1),2,Vector2i.ZERO,new_tile_array[0])	
		#tr
		#surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y))
		map.set_cell(Vector2i(selected_tile.x+1,selected_tile.y),2,Vector2i.ZERO,new_tile_array[1])
		#br
		#surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y+1))
		map.set_cell(Vector2i(selected_tile.x+1,selected_tile.y+1),2,Vector2i.ZERO,new_tile_array[2])	
		#b
		#surrounding_tile=(Vector2i(clicked_tile.x,clicked_tile.y+1))
		map.set_cell(Vector2i(selected_tile.x,selected_tile.y+1),2,Vector2i.ZERO,new_tile_array[3])
		#bl
		#surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y+1))
		map.set_cell(Vector2i(selected_tile.x-1,selected_tile.y+1),2,Vector2i.ZERO,new_tile_array[4])	
		#tl
		#surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y))
		map.set_cell(Vector2i(selected_tile.x-1,selected_tile.y),2,Vector2i.ZERO,new_tile_array[5])	
		
			
			
			
			
