package ;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class EndScreen extends FlxState
{

	/*public function new() 
	{
		super();
	}*/
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		bgColor = 0xFF000000;
		
	}
	
	function kjrwImage(obj:FlxText)
	{
		remove(obj);
	}
}