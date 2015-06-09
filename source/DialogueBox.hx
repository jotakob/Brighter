package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import haxe.xml.Fast;
import openfl.events.Event;

/**
 * ...
 * @author JJM
 */
class DialogueBox extends FlxGroup
{
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
		FlxG.stage.addEventListener(Event.ADDED_TO_STAGE, test);
		y = FlxG.height - height;
		width = FlxG.width;
		background = new FlxSprite(0, y);
		background.scrollFactor.set();
		background.x = 0;
		background.y = y;
		background.height = 64;
		background.width = width;
		background.makeGraphic(width, height, 0x222288);
		background.alpha = 0.5;
		add(background);
		
		speakerTextBox = new FlxText(0, 0, width - 20, "", 16);
		speakerTextBox.scrollFactor.set();
		speakerTextBox.x = 10;
		speakerTextBox.y = y + 10;
		textBox = new FlxText(10, y + 60, width - 20, "", 16);
		textBox.scrollFactor.set();
		textBox.x = 10;
		textBox.y = y + 60;
		add(speakerTextBox);
		add(textBox);
	}
	
	function test (e:Event)
	{
		trace("Hi!");
	}
	
	public function setText(text:String, _speaker:String)
	{
		speaker = _speaker;
		textBox.text = text;
		trace(speaker + ": " + text);
		Reg.currentState.ui.add(this);
	}
	
	public function hide()
	{
		Reg.currentState.ui.remove(this);
	}
}