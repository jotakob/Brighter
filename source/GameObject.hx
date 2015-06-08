package ;

import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author JJM
 */
class GameObject extends FlxObject
{
	public var graphicComponent:FlxSprite;
	
	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0) 
	{
		super(X, Y, Width, Height);
		
	}
	
	public function activate()
	{
		
	}
}