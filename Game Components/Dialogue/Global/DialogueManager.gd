extends Node

var currentDialogue:Dialogue
var curSpeechIndex:int = 0

func setNewDialogue(new:Dialogue):
	currentDialogue = new
	curSpeechIndex = 0

func getDialogueEvent() -> DialogueEvents:
	if curSpeechIndex > currentDialogue.ev.size()-1:
		return null
	
	return currentDialogue.ev[curSpeechIndex]

func advanceDialogue():
	curSpeechIndex += 1
