extends CharacterBody2D

@export var move_amount = 1
@export var health = 2
@export var attack_power = 1
@export var speed = 0

var move_cooldown = false

@onready var move_holder: Node2D = $MoveHolder

var rotation_amounts = [0,57,123,180,237,303]


func take_damage(damage):
	health -= damage
	$Label.text = str(health)
	if health <=0:
		death()


	
	
func death():
	queue_free()
