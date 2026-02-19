extends Control

@export var speakerKey:String = "player"

@onready var animation = $AnimationPlayer
@onready var txtMessage = $Panel/Label

var charTween:Tween

func startDialogue():
	animation.play("Appear")

func setText(speechText):
	txtMessage.text = speechText
	animateText()

func animateText():
	txtMessage.visible_characters = 0
	charTween = create_tween()
	charTween.tween_property(txtMessage, "visible_characters", txtMessage.get_total_character_count(), 1.0)

func isComplete():
	return !charTween.is_running()

func completeDialogue():
	charTween.stop()
	txtMessage.visible_characters = txtMessage.get_total_character_count()

func endDialogue():
	animation.play("Disappear")
