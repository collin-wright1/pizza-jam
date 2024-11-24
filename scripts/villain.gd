extends CharacterBody2D

@export var move_amount = 1
@export var health = 1
@export var attack_power = 1
@export var speed = 0
@export var movement_speed = 2
@onready var move_checker: RayCast2D = $MoveChecker

@onready var attack_holder: Node2D = $AttackHolder
const DAMAGE_NUMBER = preload("res://scenes/damage_number.tscn")
var rotation_amounts = [0,57,123,180,237,303]
var destination : Vector2 = position
var move_cooldown : bool = true

var can_attack : bool = false
var attack_targets = []

func _ready() -> void:
	for hitbox in attack_holder.get_children():
		if hitbox is Area2D:
			hitbox.body_entered.connect(on_enemy_targeted)
			hitbox.body_exited.connect(on_enemy_left)

func _process(delta: float) -> void:
	if(move_cooldown == false):
		position = position.move_toward(destination, movement_speed)
		if(position == destination):
			move_cooldown = true
	if rotation_degrees == 60:
		rotation_degrees = 57
	if rotation_degrees == 120:
		rotation_degrees = 123
	if rotation_degrees == 240:
		rotation_degrees = 237
	if rotation_degrees == 300:
		rotation_degrees = 303
	

func _input(event: InputEvent) -> void:
	pass
	#if event is InputEventKey:
		#if event.pressed and event.keycode == KEY_SPACE:
			#target_hero()
			#move_forward()

		#else:
			#pass

func attack():
	for enemy in attack_targets:
		if enemy.has_method("take_damage") and enemy.is_in_group("Hero"):
			enemy.take_damage(attack_power)

func on_enemy_targeted(body):
	attack_targets.append(body)
	
func on_enemy_left(body):
	attack_targets.pop_at(attack_targets.find(body))
			
func take_damage(damage):
	health -= damage
	var dam_num_instance = DAMAGE_NUMBER.instantiate()
	add_child(dam_num_instance)
	if health <=0:
		death()
		
func move_forward():
	#print(position, destination)
	if(move_cooldown == true and !move_checker.is_colliding()):
		print(snapped(rotation_degrees, 60))
		if(snapped(rotation_degrees, 60) == 0):
			destination = Vector2(position.x, position.y + 100)
		elif(snapped(rotation_degrees, 60) == 60):
			destination = Vector2(position.x - 75, position.y + 50)
		elif(snapped(rotation_degrees, 60) == 120):
			destination = Vector2(position.x - 75, position.y - 50)
			print("Debuggin")
		elif(snapped(rotation_degrees, 60) == -180 or snapped(rotation_degrees, 60) == 180):
			print("Debuggin2")
			destination = Vector2(position.x, position.y - 100)
		elif(snapped(rotation_degrees, 60) == -120):
			destination = Vector2(position.x + 75, position.y - 50)
		elif(snapped(rotation_degrees, 60) == -60):
			destination = Vector2(position.x + 75, position.y + 50)
		move_cooldown = false
		
func target_hero():
	var heroes = get_tree().get_nodes_in_group("Hero")
	var nearest_hero = null
	for hero in heroes:
		if(nearest_hero == null):
			nearest_hero = hero
		elif(position.distance_to(hero.position) < position.distance_to(nearest_hero.position)):
			nearest_hero = hero
	if(nearest_hero != null):
		print(nearest_hero)
		look_at(nearest_hero.position)
		rotation_degrees -= 90
		
func death():
	queue_free()
