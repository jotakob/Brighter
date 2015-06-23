package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import haxe.xml.Fast;
import haxe.Timer;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

/**
 * This class manages the dialogue box at the bottom of the screen
 * @author Jakob
 */
class DialogueBox extends FlxGroup
{
	private var currentConversation:Dynamic;
	private var leftSpeaker:String = "";
	private var rightSpeaker:String = "";
	private var leftImage:FlxSprite;
	private var rightImage:FlxSprite;
	private var background:FlxSprite;
	private var textBox:FlxText;
	private var highlighted = new FlxTextFormat(0xFFFF00, true);
	private var textBoxFormat = new FlxTextFormat(0xFFFFFF, false);
	private var width:Int;
	private var height:Int = 64;
	private var y:Int;
	private var currentChoice:Int = -1;
	private var choiceLength:Int;
	private var talkingToChild:Bool;

	public function new()
	{
		super();
		
		y = FlxG.height - height;
		width = FlxG.width;
		background = new FlxSprite(0, y);
		background.scrollFactor.set();
		background.x = 0;
		background.y = y;
		background.height = 64;
		background.width = width;
		background.makeGraphic(width, height, 0x88222288);
		add(background);
		
		textBox = new FlxText(0, 0, width - 20, "", 16);
		textBox.scrollFactor.set();
		textBox.x = 10;
		textBox.y = y + 10;
		textBox.addFormat(textBoxFormat);
		add(textBox);
	}
	
	private function setSpeaker(speaker:String)
	{
		remove(leftImage);
		remove(rightImage);
		
		if (leftSpeaker == speaker)
		{
			add(leftImage);
		}
		else if (rightSpeaker == speaker)
		{
			add (rightImage);
		}
		else
		{
			if (speaker == "player")
			{
				leftSpeaker == speaker;
				leftImage = new FlxSprite(4, 0, "sprites/character-" + Reg.settings.gender + "-face.png");
				leftImage.scrollFactor.set();
				leftImage.y = this.y - leftImage.height;
				add(leftImage);
			}
			else if ((speaker == "bird") || (speaker.substr(0, 5) == "child"))
			{
				rightSpeaker = speaker;
				rightImage = new FlxSprite(0, 0, "sprites/" + speaker + "-face.png");
				rightImage.setFacingFlip(FlxObject.RIGHT, true, false);
				rightImage.facing = FlxObject.RIGHT;
				rightImage.scrollFactor.set();
				rightImage.x = this.width - rightImage.width - 4;
				rightImage.y = this.y - this.height;
				add(rightImage);
			}
			else
			{
				trace("speaker not found");
			}
		}
	}
	
	public function setText(text:String, speaker:String)
	{
		currentChoice = -1;
		setSpeaker(speaker);
		textBox.removeFormat(highlighted);
		textBox.removeFormat(textBoxFormat);
		textBox.text = text;
		textBox.addFormat(textBoxFormat);
		Reg.currentState.ui.add(this);
	}
	
	public function choiceBox(choice1:String, choice2:String)
	{
		currentChoice = 1;
		setSpeaker("player");
		choiceLength = choice1.length;
		textBox.text = choice1 + "\n" + choice2;
		textBox.addFormat(highlighted, 0, choiceLength);
	}
	
	/**
	 * Continues the dialogue if the interact key (or enter) is pressed
	 * @param	e
	 */
	public function onKeyDown(e:KeyboardEvent)
	{
		if (e.keyCode == Keyboard.ENTER || FlxG.keys.anyJustPressed(Reg.settings.interactKeys))
		{
			if (currentChoice > -1)
			{
				Reg.currentChild.status = (currentChoice == 1 ? Child.YES_HELP : Child.NO_HELP);
				chooseAction();
			}
			else if (currentConversation.hasNext())
			{
				var text:Fast = currentConversation.next();
				setText(text.innerData, text.att.speaker);
			}
			else 
			{
				chooseAction();
			}
		}
		else if ((e.keyCode == Keyboard.W || e.keyCode == Keyboard.UP) && currentChoice > -1)
		{
			currentChoice = 1;
			textBox.addFormat(textBoxFormat);
			textBox.addFormat(highlighted, 0, choiceLength);
		}
		else if ((e.keyCode == Keyboard.S || e.keyCode == Keyboard.DOWN) && currentChoice > -1)
		{
			currentChoice = 2;
			textBox.addFormat(textBoxFormat);
			textBox.addFormat(highlighted, choiceLength + 1, textBox.text.length);
		}
	}
	
	private function chooseAction()
	{
		if (talkingToChild)
		{
			switch Reg.currentChild.status
			{
				case Child.NOT_MET, Child.WRONG_ANSWER, Child.NO_HELP:
					Reg.currentChild.status = Child.MET;
					continueGame();
					
				case Child.MET:
					for (conv in Reg.currentChild.dialogue.elements)
					{
						if (conv.att.id == "metchoice")
						{
							choiceBox(conv.node.item1.innerData, conv.node.item2.innerData);
							break;
						}
					}
					
				case Child.YES_HELP:
					Reg.ui.knowledgeBox.show(2);
					//continueGame();
					
				case Child.SOLVED:
					continueGame();
			}
		}
		else
		{
			continueGame();
		}
	}
	
	private function continueGame()
	{
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Reg.currentState.ui.remove(this);
		Timer.delay(Reg.player.setMovable, 50);
	}
	
	/**
	 * Display a set of dialogue
	 * @param	conversation a set of dialoge from an XML file
	 */
	public function displayDialogue(conversation:Fast, child:Bool)
	{
		
		Reg.currentState.ui.add(this);
		talkingToChild = child;
		
		currentConversation = conversation.elements;
		var text:Fast = currentConversation.next();
		setText(text.innerData, text.att.speaker);
		Reg.player.movable = false;
		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
}