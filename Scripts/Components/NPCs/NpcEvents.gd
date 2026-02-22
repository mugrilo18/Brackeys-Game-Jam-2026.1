extends Node2D

@onready var eventTime = $EventTime

@export var npcKey:String = "npc"
@export var parent:Node2D
@export var sprite:AnimatedSprite2D
@export var dialogueBox: DialogueBoxUI

func setEvent(event:DialogueEvents):
	if event is SpeechEvent:
		setSpeechDialogue(event)
	elif event is AnimationEvent:
		setAnimationDialogue(event)

func closeSpeechDialogue():
	if dialogueBox == null:
		print("Can't close dialogue, DialogueBox was not set")
		return
	
	if dialogueBox.visible:
		dialogueBox.endDialogue()

func setSpeechDialogue(event:SpeechEvent):
	if dialogueBox == null:
		print("Can't play event, DialogueBox was not set")
		return
	
	if !dialogueBox.visible:
		dialogueBox.startDialogue()
	
	dialogueBox.setText(event.message)

func setAnimationDialogue(event:AnimationEvent):
	if parent == null or sprite == null:
		print("Can't play event, parent or sprite weren't set")
		return
	
	if dialogueBox != null and dialogueBox.visible:
		dialogueBox.endDialogue()
	
	#Animate
	sprite.play(event.animationStr)
	sprite.flip_h = event.flipSprite
	
	#Set timer
	var time = event.animationTime
	
	if event.animationTime == 0:
		var frame_count = sprite.sprite_frames.get_frame_count(event.animationStr)
		var fps = sprite.sprite_frames.get_animation_speed(event.animationStr)
		var speed_scale = sprite.speed_scale
		time = (frame_count / fps) / speed_scale
	
	eventTime.wait_time = time
	eventTime.start()
	
	#TweenPos
	if event.newPos == Vector2(0, 0):
		return
	
	var tween = create_tween()
	tween.tween_property(parent, "global_position:x", event.newPos.x, time)

func _on_event_time_timeout() -> void:
	parent.eventDone.emit()
