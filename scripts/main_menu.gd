extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animation_player.play("menu",-1,0.2)


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_controller.tscn")

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func _on_instruction_button_pressed() -> void:
	$"Instruction Panel".show()


func _on_instruction_exit_pressed() -> void:
	$"Instruction Panel".hide()
