extends Node2D
@onready var visual: Node2D = $Visualmap
@onready var map: TileMapLayer = $TileMapLayer
@onready var visual_map: TileMapLayer = $Visualmap/VisualSelection
@onready var hero_holder: Node2D = $HeroHolder
@onready var enemy_holder: Node2D = $EnemyHolder


var selected_tile
var rotated_characters = []


enum game_states{
	picking,
	rotating
}
var game_state = game_states.picking


func _ready() -> void:
	for hero in hero_holder.get_children():
		get_parent().characters.append(hero)
	for enemy in enemy_holder.get_children():
		get_parent().characters.append(enemy)

func _physics_process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	
	match game_state:
		game_states.picking:
			if event is InputEventMouseButton and !visual.anim.is_playing() and get_parent().spins > 0:
				if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and check_for_walls(map.local_to_map(get_global_mouse_position())):
					get_parent().decrement_spin()
					#game_state = game_states.rotating
					$Visualmap.get_node("AnimationPlayer").play("raise_up", -1, 2)
					visual_map.show()

					var clicked_tile = map.local_to_map(get_global_mouse_position())
					selected_tile = clicked_tile
					print(map.map_to_local(clicked_tile))
					visual_map.get_parent().position = map.map_to_local(Vector2(clicked_tile.x,clicked_tile.y))
					
					
					print(map.local_to_map(get_global_mouse_position()))
					#print(visual_map.local_to_map(get_global_mouse_position()))
					var surrounding_tile = Vector2i(clicked_tile)
					
					#for i in Global.characters:
						#print(get_character_on_tile(map.local_to_map(i.global_position)))
					rotated_characters = []
					visual.get_node("RotateHolder").rotation = 0
					if clicked_tile.x % 2 == 0:
						#center,t,tr,br,b,bl,tl
						
						visual_map.clear()
						#center
						visual_map.set_cell(Vector2i.ZERO,map.get_cell_source_id(clicked_tile),map.get_cell_atlas_coords(clicked_tile),map.get_cell_alternative_tile(clicked_tile))
						rotated_characters.append(get_character_on_tile(clicked_tile))
						if get_character_on_tile(clicked_tile) != null:
							visual.get_node("RotateHolder").get_child(0).texture = get_character_on_tile(clicked_tile).get_node_or_null("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(0).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(0).texture = null	
						#t
						surrounding_tile = (Vector2i(clicked_tile.x,clicked_tile.y-1))
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						visual_map.set_cell(surrounding_tile - clicked_tile,map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))
						if get_character_on_tile(surrounding_tile) != null:
							visual.get_node("RotateHolder").get_child(1).texture = get_character_on_tile(surrounding_tile).get_node("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(1).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(1).texture = null			
						#tr
						surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y-1))
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						visual_map.set_cell(surrounding_tile-clicked_tile,map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))
						if get_character_on_tile(surrounding_tile) != null:
							visual.get_node("RotateHolder").get_child(2).texture = get_character_on_tile(surrounding_tile).get_node("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(2).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(2).texture = null				
						#br
						surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y))
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						visual_map.set_cell(surrounding_tile-clicked_tile,map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))	
						if get_character_on_tile(surrounding_tile) != null:	
							visual.get_node("RotateHolder").get_child(3).texture = get_character_on_tile(surrounding_tile).get_node("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(3).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(3).texture = null			
						#b
						surrounding_tile=(Vector2i(clicked_tile.x,clicked_tile.y+1))
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						visual_map.set_cell(surrounding_tile-clicked_tile,map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))
						if get_character_on_tile(surrounding_tile) != null:
							visual.get_node("RotateHolder").get_child(4).texture = get_character_on_tile(surrounding_tile).get_node("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(4).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(4).texture = null				
						#bl
						surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y))
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						visual_map.set_cell(surrounding_tile-clicked_tile,map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))
						if get_character_on_tile(surrounding_tile) != null:
							visual.get_node("RotateHolder").get_child(5).texture = get_character_on_tile(surrounding_tile).get_node("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(5).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(5).texture = null	
						#tl
						surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y-1))
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						visual_map.set_cell(surrounding_tile-clicked_tile,map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))
						if get_character_on_tile(surrounding_tile) != null:
							visual.get_node("RotateHolder").get_child(6).texture = get_character_on_tile(surrounding_tile).get_node("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(6).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(6).texture = null

					else:
						visual_map.clear()
						#center
						rotated_characters.append(get_character_on_tile(clicked_tile))

						visual_map.set_cell(Vector2i.ZERO,map.get_cell_source_id(clicked_tile),map.get_cell_atlas_coords(clicked_tile),map.get_cell_alternative_tile(clicked_tile))		
						if get_character_on_tile(clicked_tile) != null:
							visual.get_node("RotateHolder").get_child(0).texture = get_character_on_tile(clicked_tile).get_node_or_null("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(0).rotation = get_character_on_tile(clicked_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(0).texture = null	
						
						
						#t
						surrounding_tile = (Vector2i(clicked_tile.x,clicked_tile.y-1))
						visual_map.set_cell(surrounding_tile - clicked_tile,map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))	
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						if get_character_on_tile(surrounding_tile) != null:
							visual.get_node("RotateHolder").get_child(1).texture = get_character_on_tile(surrounding_tile).get_node_or_null("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(1).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(1).texture = null	
								
						#tr
						surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y))
						visual_map.set_cell(Vector2i(surrounding_tile.x-clicked_tile.x,surrounding_tile.y-clicked_tile.y-1),map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						if get_character_on_tile(surrounding_tile) != null:
							visual.get_node("RotateHolder").get_child(2).texture = get_character_on_tile(surrounding_tile).get_node_or_null("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(2).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(2).texture = null		
						#br
						surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y+1))
						visual_map.set_cell(Vector2i(surrounding_tile.x-clicked_tile.x,surrounding_tile.y-clicked_tile.y-1),map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						if get_character_on_tile(surrounding_tile) != null:
							visual.get_node("RotateHolder").get_child(3).texture = get_character_on_tile(surrounding_tile).get_node_or_null("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(3).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(3).texture = null
						#b
						surrounding_tile=(Vector2i(clicked_tile.x,clicked_tile.y+1))
						visual_map.set_cell(surrounding_tile-clicked_tile,map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))	
						
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						if get_character_on_tile(surrounding_tile) != null:
							visual.get_node("RotateHolder").get_child(4).texture = get_character_on_tile(surrounding_tile).get_node_or_null("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(4).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(4).texture = null
						#bl
						surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y+1))
						visual_map.set_cell(Vector2i(surrounding_tile.x-clicked_tile.x,surrounding_tile.y-clicked_tile.y-1),map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						if get_character_on_tile(surrounding_tile) != null:
							visual.get_node("RotateHolder").get_child(5).texture = get_character_on_tile(surrounding_tile).get_node_or_null("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(5).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(5).texture = null	
						#tl
						surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y))
						visual_map.set_cell(Vector2i(surrounding_tile.x-clicked_tile.x,surrounding_tile.y-clicked_tile.y-1),map.get_cell_source_id(surrounding_tile),map.get_cell_atlas_coords(surrounding_tile),map.get_cell_alternative_tile(surrounding_tile))
						rotated_characters.append(get_character_on_tile(surrounding_tile))
						if get_character_on_tile(surrounding_tile) != null:
							visual.get_node("RotateHolder").get_child(6).texture = get_character_on_tile(surrounding_tile).get_node_or_null("Sprite2D").texture
							visual.get_node("RotateHolder").get_child(6).rotation = get_character_on_tile(surrounding_tile).rotation
						else:
							visual.get_node("RotateHolder").get_child(6).texture = null
					await get_tree().create_timer(0.5).timeout
					visual.rotate_right()
			
		#game_states.rotating:
			#if event is InputEventMouseButton:
				#if event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
					#game_state = game_states.picking
					#$Visualmap.get_node("AnimationPlayer").play("lower_down")
					##visual_map.hide()
		
		
func apply_rotation(new_tile_array):
	
	#print(selected_tile)
	#print(new_tile_array)
	
	for i in rotated_characters.size():
		if rotated_characters[i]!=null:			
			var new_position = $Visualmap/RotateHolder.get_child(i).global_position
			#new_position.x = snapped(new_position.x,15)
			#new_position.y = snapped(new_position.y,25)
			rotated_characters[i].global_position = map.map_to_local(map.local_to_map(new_position))
			rotated_characters[i].global_rotation_degrees = $Visualmap/RotateHolder.get_child(i).global_rotation_degrees
			rotated_characters[i].rotation_degrees = roundf(snapped(rotated_characters[i].rotation_degrees,60))
			
			#print(rotated_characters[i].rotation_degrees)
	if selected_tile.x % 2 == 0:
		#surrounding_tile = (Vector2i(selected_tile.x,selected_tile.y-1))
		map.set_cell(Vector2i(selected_tile.x,selected_tile.y-1),1,new_tile_array[0],0)		
		#tr
		#surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y-1))
		map.set_cell(Vector2i(selected_tile.x+1,selected_tile.y-1),1,new_tile_array[1],0)	
		#br
		#surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y))
		map.set_cell(Vector2i(selected_tile.x+1,selected_tile.y),1,new_tile_array[2],0)	
		#b
		#surrounding_tile=(Vector2i(clicked_tile.x,clicked_tile.y+1))
		map.set_cell(Vector2i(selected_tile.x,selected_tile.y+1),1,new_tile_array[3],0)		#bl
		#surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y))
		map.set_cell(Vector2i(selected_tile.x-1,selected_tile.y),1,new_tile_array[4],0)	
		#tl
		#surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y-1))
		map.set_cell(Vector2i(selected_tile.x-1,selected_tile.y-1),1,new_tile_array[5],0)	
	else:
		#t
		#surrounding_tile = (Vector2i(clicked_tile.x,clicked_tile.y-1))
		map.set_cell(Vector2i(selected_tile.x,selected_tile.y-1),1,new_tile_array[0],0)	
		#tr
		#surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y))
		map.set_cell(Vector2i(selected_tile.x+1,selected_tile.y),1,new_tile_array[1],0)
		#br
		#surrounding_tile=(Vector2i(clicked_tile.x+1,clicked_tile.y+1))
		map.set_cell(Vector2i(selected_tile.x+1,selected_tile.y+1),1,new_tile_array[2],0)	
		#b
		#surrounding_tile=(Vector2i(clicked_tile.x,clicked_tile.y+1))
		map.set_cell(Vector2i(selected_tile.x,selected_tile.y+1),1,new_tile_array[3],0)
		#bl
		#surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y+1))
		map.set_cell(Vector2i(selected_tile.x-1,selected_tile.y+1),1,new_tile_array[4],0)	
		#tl
		#surrounding_tile=(Vector2i(clicked_tile.x-1,clicked_tile.y))
		map.set_cell(Vector2i(selected_tile.x-1,selected_tile.y),1,new_tile_array[5],0)	
		
			
func check_for_walls(center_tile : Vector2i):
	
	if map.get_cell_atlas_coords(center_tile) == Vector2i(2,0):
		return false
	
	if center_tile.x % 2 == 0:			
		if map.get_cell_atlas_coords(Vector2i(center_tile.x,center_tile.y-1)) == Vector2i(2,0):
			return false
			
		if map.get_cell_atlas_coords(Vector2i(center_tile.x+1,center_tile.y)) == Vector2i(2,0):
			return false
		
		if map.get_cell_atlas_coords(Vector2i(center_tile.x+1,center_tile.y+1)) == Vector2i(2,0):
			return false
		
		if map.get_cell_atlas_coords(Vector2i(center_tile.x,center_tile.y+1)) == Vector2i(2,0):
			return false
		
		if map.get_cell_atlas_coords(Vector2i(center_tile.x-1,center_tile.y)) == Vector2i(2,0):
			return false
		
		if map.get_cell_atlas_coords(Vector2i(center_tile.x-1,center_tile.y-1)) == Vector2i(2,0):
			return false
	else:
		if map.get_cell_atlas_coords(Vector2i(center_tile.x,center_tile.y-1)) == Vector2i(2,0):
			return false
			
		if map.get_cell_atlas_coords(Vector2i(center_tile.x+1,center_tile.y-1)) == Vector2i(2,0):
			return false
		
		if map.get_cell_atlas_coords(Vector2i(center_tile.x+1,center_tile.y)) == Vector2i(2,0):
			return false
		
		if map.get_cell_atlas_coords(Vector2i(center_tile.x,center_tile.y+1)) == Vector2i(2,0):
			return false
		
		if map.get_cell_atlas_coords(Vector2i(center_tile.x-1,center_tile.y+1)) == Vector2i(2,0):
			return false
		
		if map.get_cell_atlas_coords(Vector2i(center_tile.x-1,center_tile.y)) == Vector2i(2,0):
			return false
		
	return true

func get_character_on_tile(tile_coord):
	get_parent().clean_characters()
	for character in get_parent().characters:
		if map.local_to_map(character.global_position) == tile_coord:
			#print(character)
			return character
	return null
			
