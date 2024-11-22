extends State

#var game_variables: var
@export var end_turn_button : Button

func Enter():
	pass
	
func Update(delta):
	pass
	
func Exit():
	pass

func _on_button_pressed() -> void:
	if(Global.game_state.name.to_lower() == "player_turn"):
		Transitioned.emit(self, "ai_turn")
