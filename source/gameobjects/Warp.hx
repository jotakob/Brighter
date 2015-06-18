package ;

import flixel.FlxObject;

/**
 * A warp transports the player to a different level or place upon activation
 * @author Jakob
 */
class Warp extends GameObject
{
	/**
	 * The target level of the warp
	 */
	public var target:String;
	
	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0) 
	{
		super(X, Y, Width, Height);
		
	}
	
	public override function activate()
	{
		Reg.currentState.newLevel(target);
	}
}