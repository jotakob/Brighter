package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import haxe.xml.Fast;

/**
 * ...
 * @author JJM
 */
class DialogueBox extends FlxGroup
{
	private var speaker:String;
	private var speakerName:String;
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
		background.height = 64;
		background.width = width;
		background.makeGraphic(width, height, 0x222288);
		background.alpha = 0.5;
		background.scrollFactor.set();
		add(background);
		
		speakerTextBox = new FlxText(10, y + 10, width - 20, "", 16);
		speakerTextBox.scrollFactor.set();
		textBox = new FlxText(10, y + 60, width - 20, "", 16);
		textBox.scrollFactor.set();
		add(speakerTextBox);
		add(textBox);
	}
	
	public function setText(text:String, _speaker:String, _speakerName:String)
	{
		speaker = _speaker;
		speakerName = _speakerName;
		textBox.text = text;
		trace(speakerName + ": " + text);
	}
}