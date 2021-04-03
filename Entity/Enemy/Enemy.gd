extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite
onready var animPrefix = animatedSprite.animation

enum {
	RUN,
	IDLE,
}
var state = IDLE

func _ready():
	var animPrefixRegex = RegEx.new()
	animPrefixRegex.compile("([a-zA-Z]+_)+")
	var prefix = animPrefixRegex.search(animatedSprite.animation)
	if prefix: animPrefix = prefix.get_string()
	to_idle()

func to_idle():
	state = IDLE
	animatedSprite.animation = animPrefix + "idle"

func to_run():
	state = RUN
	animatedSprite.animation = animPrefix + "run"
