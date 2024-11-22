extends State

#var game_variables: var
var offset: bool = false

func Enter():
	pass
	
func Update(delta):
	pass
	
func Exit():
	pass

func _on_button_pressed() -> void:
	if(Global.game_state.name.to_lower() == "ai_turn"):
		if(offset):
			Transitioned.emit(self, "player_turn")
			offset = false
		else:
			offset = true
