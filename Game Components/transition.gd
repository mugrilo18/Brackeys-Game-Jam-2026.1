extends CanvasLayer

@onready var animation = $AnimationPlayer

func transitionToScene(scene:String):
	animation.play("FadeIn")
	await animation.animation_finished
	get_tree().change_scene_to_file(scene)
	animation.play("FadeOut")

func playFadeIn():
	animation.play("FadeIn")

func playFadeOut():
	animation.play("FadeOut")
