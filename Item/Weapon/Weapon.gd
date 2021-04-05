extends "res://Item/Item.gd"

var brandishing = false
onready var animationPlayer = $AnimationPlayer
onready var position2D = $Position2D

func _ready():
	if drop:
		position2D.rotation_degrees = 0

func do_brandish():
	if brandishing: return
	brandishing = true
	animationPlayer.play("brandish")

func stop_brandish():
	if !brandishing: return
	brandishing = false
	animationPlayer.stop()

func is_brandish():
	return brandishing

func _on_AnimationPlayer_animation_finished(anim_name):
	if brandishing:
		animationPlayer.play("brandish")
