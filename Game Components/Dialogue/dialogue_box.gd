extends Control

@export var speakerKey:String = "player"

@onready var animation = $AnimationPlayer
@onready var txtMessage = $Panel/Label

var charTween:Tween

signal dialogueEnded

func startDialogue():
	animation.play("Appear")
	setText()

func setText():
	var speech:Speech = DialogueManager.getDialogueSpeech()
	
	if speech == null or speech.speakerKey != speakerKey:
		endDialogue()
		return
	
	txtMessage.text = speech.message
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


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Disappear":
		dialogueEnded.emit()
