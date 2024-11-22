extends CharacterBody2D

@export var move_amount = 1
@export var health = 1
@export var attack_power = 1
@export var speed = 0

@onready var move_holder: Node2D = $MoveHolder

var rotation_amounts = [0,57,123,180,237,303]


func take_damage(damage):
	health -= damage
	if health <=0:
		death()

func attack():
	for hitbox in move_holder.get_children():
		if hitbox is Area3D:
			hitbox.monitoring = true
	
func on_enemy_targeted(body):
	if body.is_in_group("Hero"):
		if body.has_method("take_damage"):
			body.take_damage	
	
func death():
	queue_free()
