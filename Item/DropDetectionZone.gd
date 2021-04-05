extends Node2D

var player = null
var velocity = Vector2.ZERO
onready var playerDetectionZone = $PlayerDetectionZone
onready var pickUpDetectionZone = $PickUpDetectionZone

signal picked_up

func can_see_player():
	return player != null

func _physics_process(delta):
	if !can_see_player():
		velocity = Vector2.ZERO
		return
	get_parent().position += (player.global_position - global_position) / 10

func _on_PlayerDetectionZone_body_entered(body):
	player = body

func _on_PlayerDetectionZone_body_exited(body):
	player = null

func _on_PickUpDetectionZone_body_entered(body):
	emit_signal("picked_up")
	player = null
	queue_free()
