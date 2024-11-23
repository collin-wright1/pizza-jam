extends Node2D


var turns : int = 0
var spins = 3

var characters = []

var characters_have_moved = true

#var game_state: State
@onready var button: Button = $TestArea/CanvasLayer/Panel/Button


enum game_states{
	player_turn,
	ai_turn
}
var current_game_state = game_states.player_turn


func _process(delta: float) -> void:
	match current_game_state:
		game_states.player_turn:
			if spins == 0:
				button.disabled = false
			else:
				button.disabled = true
			
		game_states.ai_turn:
			print("Ai turn")
			
			if(characters_have_moved == false):
				for unit in characters:
					unit.move_forward()
				characters_have_moved = true
			
			#TODO enemy move?
			
			#TODO Hero/Enemy Attack Phase
			
			await get_tree().create_timer(1).timeout
			spins = 4
			decrement_spin()
			current_game_state = game_states.player_turn
			
			
			
			
			


func decrement_spin():
	spins -= 1
	$TestArea/CanvasLayer/Panel/SpinsLabel.text = str(spins)
	


func _on_button_pressed() -> void:
	characters_have_moved = false
	current_game_state = game_states.ai_turn
	button.disabled = true
