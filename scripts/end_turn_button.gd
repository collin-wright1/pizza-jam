extends Button

@export var game_state : Node

#func _pressed():
	#print("pressed")
	#if(Global.game_state.name.to_lower() == "ai_turn"):
		#text = "Begin Turn"
	#elif Global.spins == 0:
		#text = "End Turn"
