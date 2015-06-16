package ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author Marijn Metzlar
 */

class MovingObject extends GameObject
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super();
		
		graphicComponent = new FlxSprite(X, Y);
		graphicComponent.loadGraphic("Art/block-moving.png", false, 16, 16, true);
	}
}