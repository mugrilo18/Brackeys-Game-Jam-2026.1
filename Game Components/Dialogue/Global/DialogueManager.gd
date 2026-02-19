extends Node

var currentDialogue:Dialogue
var curSpeechIndex:int = 0

func setNewDialogue(new:Dialogue):
	currentDialogue = new
	curSpeechIndex = 0

func getDialogueSpeech() -> Speech:
	if curSpeechIndex > currentDialogue.txt.size()-1:
		return null
	
	return currentDialogue.txt[curSpeechIndex]

func advanceDialogue():
	curSpeechIndex += 1
