package ;

import flixel.FlxObject;

/**
 * ...
 * @author ...
 */
class Warp extends FlxObject
{
	public var target:String;
	
	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0) 
	{
		super(X, Y, Width, Height);
		
	}
	
	public function activate()
	{
		Reg.currentState.newLevel(target);
	}
}