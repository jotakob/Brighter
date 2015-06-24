package ;

import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * A generic game object
 * @author JJM
 */
class GameObject extends FlxObject
{
	public var graphicComponent:FlxSprite;
	public var name:String;
	
	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0) 
	{
		super(X, Y, Width, Height);
	}
	
	/**
	 * Gets called when the object is activated by the player.
	 * To be overridden in child classes
	 */
	public function activate()
	{
		
	}
}