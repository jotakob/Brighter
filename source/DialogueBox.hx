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
}