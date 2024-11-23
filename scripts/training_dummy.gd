extends CharacterBody2D

@export var move_amount = 1
@export var health = 2
@export var attack_power = 1
@export var speed = 0
const DAMAGE_NUMBER = preload("res://scenes/damage_number.tscn")
var move_cooldown = true

@onready var move_holder: Node2D = $MoveHolder

var rotation_amounts = [0,57,123,180,237,303]


func take_damage(damage):
	health -= damage
	var dam_num_instance = DAMAGE_NUMBER.instantiate()
	$Label.text = str(health)
	add_child(dam_num_instance)
	dam_num_instance.get_child(0).play("spawn")
	if health <=0:
		death()


	
	
func death():
	queue_free()
