extends KinematicBody2D

const ACCELERATION = 10
const MAX_SPEED = 100
const ROLL_SPEED = MAX_SPEED * 1.3
var velocity = Vector2.ZERO
var input_dir = Vector2.ZERO
var dodge_dir = Vector2.RIGHT

enum {
	MOVE,
	DODGE,
}
var state = MOVE

onready var attackDirIndicator = $Aim
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _process(delta):
	input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	if state == MOVE:
		if input_dir != Vector2.ZERO:
			dodge_dir = input_dir
			if input_dir.x != 0:
				var x = round(input_dir.x)
				animationTree.set("parameters/Run/blend_position", x)
				animationTree.set("parameters/Idle/blend_position", x)
				animationTree.set("parameters/Hurt/blend_position", x)
				animationTree.set("parameters/Dodge/blend_position", x)
		if Input.is_action_just_pressed("dodge"):
			state = DODGE
	
	attackDirIndicator.look_at(get_global_mouse_position())

func dodge_animation_finished():
	state = MOVE

func _physics_process(delta):
	match state:
		MOVE:
			if input_dir != Vector2.ZERO:
				animationState.travel("Run")
			else:
				animationState.travel("Idle")
			velocity = velocity.move_toward(input_dir * MAX_SPEED, ACCELERATION)
			move(velocity, delta)
		DODGE:
			animationState.travel("Dodge")
			move(dodge_dir * ROLL_SPEED, delta)

func move(vec, delta):
	move_and_slide(vec)
