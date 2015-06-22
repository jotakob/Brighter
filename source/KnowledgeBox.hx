package ;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxG;

/**
 * ...
 * @author JJM
 */
class KnowledgeBox extends FlxGroup
{
	public var background:FlxSprite;
	
	/**
	 * Current Status. 0: invisible, 1: reading, 2: selecting
	 */
	public var status:Int;
	
	private var width:Int = 192;
	private var height:Int;
	private var x:Int;
	private var y:Int = 48;

	public function new()
	{
		super();
		
		height = FlxG.height - 96;
		x = FlxG.width - 240;
		background = new FlxSprite(x, y);
		background.scrollFactor.set();
		background.x = x;
		background.y = y;
		background.height = height;
		background.width = width;
		background.makeGraphic(width, height, 0xCC3B2508);
		add(background);
	}
	
	public function show(_status:Int)
	{
		Reg.ui.add(this);
	}
}