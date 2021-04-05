extends Node2D

export var drop = false setget _set_drop
const DropDetectionZone = preload("res://Item/DropDetectionZone.tscn")

signal picked_up

func _set_drop(value):
	drop = value
	if drop && get_node("Drop"):
		return
	var dropDetectionZone = DropDetectionZone.instance()
	dropDetectionZone.connect("picked_up", self, "_on_Drop_picked_up")
	add_child(dropDetectionZone)

func _on_Drop_picked_up():
	drop = false
	emit_signal("picked_up")
	queue_free()
