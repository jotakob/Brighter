package ;

import flixel.FlxObject;

/**
 * A mundane box usable for collision
 * @author JJM
 */
class CollisionBox extends GameObject
{

	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0) 
	{
		super(X, Y, Width, Height);
		this.set_immovable(true);
	}
	
}