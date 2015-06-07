package ;

import flixel.FlxSprite;

/**
 * ...
 * @author Jakob
 */
class Child extends FlxSprite
{
	public var imagePath:String;
	
	private var name:String;
	

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, ?SimpleGraphic);
		
	}
	
	public function activate()
	{
		
	}
	
}