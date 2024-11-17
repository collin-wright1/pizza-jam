extends Node2D

@onready var map: TileMapLayer = $TileMapLayer
@onready var visual_map: TileMapLayer = $visualmap/VisualSelection


var selected_tile



func _physics_process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print(map.local_to_map(get_global_mouse_position()))
		print(visual_map.local_to_map(get_global_mouse_position()))
		var clicked_tile = map.local_to_map(get_global_mouse_position())
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
		
		
		





		
		
		
