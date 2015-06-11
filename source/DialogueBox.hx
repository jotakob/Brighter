package ;

import flixel.FlxG;
import flixel.FlxSprite;
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
	private var speaker:String;
	private var background:FlxSprite;
	private var leftImage:FlxSprite;
	private var rightImage:FlxSprite;
	private var textBox:FlxText;
	private var speakerTextBox:FlxText;
	private var width:Int;
	private var height:Int = 64;
	private var y:Int;

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
		add(speakerTextBox);
		add(textBox);
	}
	
	public function setText(text:String, _speaker:String)
	{
		speaker = _speaker;
		textBox.text = text;
		trace(speaker + ": " + text);
		Reg.currentState.ui.add(this);
		trace(textBox.x + "," + textBox.y);
	}
	
	public function hide()
	{
		Reg.currentState.ui.remove(this);
	}
	
	/**
	 * Continues the dialogue if the interact key (or enter) is pressed
	 * @param	e
	 */
	public function onKeyDown(e:KeyboardEvent)
	{
		if (e.keyCode == Keyboard.ENTER || FlxG.keys.anyJustPressed(Reg.settings.interactKeys))
		{
			if (currentConversation.hasNext())
			{
				var text:Fast = currentConversation.next();
				Reg.ui.dialogue.setText(text.innerData, text.att.speaker);
			}
			else 
			{
				switch Reg.currentChild.status
				{
					case Child.NOT_MET, Child.WRONG_ANSWER, Child.NO_HELP:
						Reg.currentChild.status = Child.MET;
						continueGame();
						
					case Child.MET:
						//TODO Choice box
						continueGame();
						
					case Child.YES_HELP:
						//TODO Knowledge choice
						continueGame();
						
					case Child.SOLVED:
						continueGame();
				}
			}
		}
	}
	
	private function continueGame()
	{
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		hide();
		Timer.delay(Reg.player.setMovable, 50);
	}
	
	/**
	 * Display a set of dialogue
	 * @param	conversation a set of dialoge from an XML file
	 */
	public function displayDialogue(conversation:Fast)
	{
		currentConversation = conversation.elements;
		var text:Fast = currentConversation.next();
		setText(text.innerData, text.att.speaker);
		Reg.player.movable = false;
		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
}