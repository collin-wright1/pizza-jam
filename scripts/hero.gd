extends CharacterBody2D

@export var move_amount = 1
@export var health = 1
@export var attack_power = 1
@export var speed = 0

@onready var move_holder: Node2D = $MoveHolder

var rotation_amounts = [0,57,123,180,237,303]
func _ready() -> void:
	for hitbox in move_holder.get_children():
		if hitbox is Area3D:
			hitbox.body_entered.connect("on_enemy_targeted")

func _process(delta: float) -> void:
	if rotation_degrees == 60:
		rotation_degrees = 57
	if rotation_degrees == 120:
		rotation_degrees = 123
	if rotation_degrees == 240:
		rotation_degrees = 237
	if rotation_degrees == 300:
		rotation_degrees = 303

func attack():
	for hitbox in move_holder.get_children():
		if hitbox is Area3D:
			var hitbox_instance = hitbox as Area3D
			hitbox_instance.monitoring = true

func on_enemy_targeted(body):
	if body.is_in_group("Enemy"):
		if body.has_method("take_damage"):
			body.take_damage
			
func take_damage(damage):
	health -= damage
	if health <=0:
		death()
		
func death():
	queue_free()
