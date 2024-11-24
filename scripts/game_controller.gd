extends Node2D


var turns : int = 0
var spins = 3

var characters = []

var characters_have_moved = true
var characters_have_attacked = false
var all_have_moved
#var game_state: State
@onready var game_over_panel: Panel = $TestArea/CanvasLayer/GameOverPanel
@onready var retry_button: Button = $TestArea/CanvasLayer/Panel/GameOverPanel/RetryButton
@onready var end_turn_button: TextureButton = $TestArea/CanvasLayer/EndTurnButton


enum game_states{
	player_turn,
	ai_turn, 
	end_game
}
var current_game_state = game_states.player_turn

func _ready():
	end_turn_button.get_node("Label").text = "3/3 Spins"

func _process(delta: float) -> void:
	match current_game_state:
		game_states.player_turn:
			for unit in characters:
				if unit.has_method("target_hero"):
					unit.target_hero()
			if spins == 0:
				end_turn_button.disabled = false
			else:
				end_turn_button.disabled = true
			
		game_states.end_game:
			game_over_panel.show()
			
		game_states.ai_turn:
			#print("Ai turn")
			
			if(characters_have_moved == false):
				for unit in characters:
					if unit.has_method("target_hero"):
						unit.target_hero()
					if unit.has_method("move_forward"):
						unit.move_forward()
				characters_have_moved = true
			all_have_moved = true
			for char in characters:
				if char.move_cooldown == false:
					all_have_moved = false
					break
				all_have_moved = true	
			
			#TODO Enemy Attack Phase
			if characters_have_attacked == false and all_have_moved == true:
				clean_characters()
				for char in characters:
					if char.has_method("attack"):
						char.attack()
					characters_have_attacked = true
			if characters_have_attacked and all_have_moved:
				#await get_tree().create_timer(1).timeout
				spins = 4
				decrement_spin()
				current_game_state = check_game(characters)

func check_game(characters):
	var heroes = []
	var enemies = []
	var game_over = true
	var level_complete = true
	for unit in characters:
		if(unit.is_in_group("Enemy")):
			enemies.append(unit)
		if(unit.is_in_group("Hero")):
			heroes.append(unit)
	for unit in heroes:
		if(unit.health > 0):
			game_over = false
	for unit in enemies:
		if(unit.health > 0):
			level_complete = false

	if(game_over):
		print("Game Over")
		return game_states.end_game
	if(level_complete):
		print("Level Complete")
		return game_states.end_game
	else:
		return game_states.player_turn


func decrement_spin():
	spins -= 1
	end_turn_button.get_node("Label").text = (str(spins) + "/3 Spins")
	if(spins <= 0):
		end_turn_button.get_node("Label").text = "End Turn"
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("show_moves"):
		for char in characters:
			if char.get_node_or_null("AttackShower"):
				char.get_node_or_null("AttackShower").show()
	if Input.is_action_just_released("show_moves"):
		for char in characters:
			if char.get_node_or_null("AttackShower"):
				char.get_node_or_null("AttackShower").hide()
	
func clean_characters():
	var new_array = []
	for char in characters:
		if is_instance_valid(char):
			new_array.append(char)
	characters = new_array.duplicate(true)
			

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_controller.tscn")


func _on_end_turn_button_pressed() -> void:
	characters_have_attacked = false
	characters_have_moved = false
	current_game_state = game_states.ai_turn
	end_turn_button.disabled = true
