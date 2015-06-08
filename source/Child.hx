package ;

import flixel.FlxObject;
import flixel.FlxSprite;
import openfl.Assets;
import AssetPaths;

/**
 * ...
 * @author Jakob
 */
class Child extends GameObject
{
	public var imagePath:String;
	
	private var name:String;
	private var childID:Int;
	

	public function new(X:Float=0, Y:Float=0, _ID:Int) 
	{
		super(X, Y, 32, 32);
		
		childID = _ID;
		graphicComponent = new FlxSprite(X, Y);
		graphicComponent.loadGraphic("sprites/child-" + childID + ".png", false, 64, 64, true);
		graphicComponent.animation.add("side", [1], 0 , false);
		graphicComponent.animation.add("front", [2], 0 , false);
		graphicComponent.animation.add("back", [3], 0 , false);
		graphicComponent.setFacingFlip(FlxObject.LEFT, true, false);
		graphicComponent.setFacingFlip(FlxObject.RIGHT, false, false);
		updateGraphics(FlxObject.UP);
	}
	
	public function updateGraphics(facing:Int = null)
	{
		if (facing != null)
		{
			graphicComponent.facing = facing;
		}
		else
		{
			facing = graphicComponent.facing;
		}
		
		if (facing == FlxObject.RIGHT || facing == FlxObject.LEFT)
		{
			graphicComponent.animation.play("side");
		}
		else 
		{
			graphicComponent.animation.play("front");
		}
		graphicComponent.x = this.x - 16;
		graphicComponent.y = this.y - 32;
	}
	
	public override function activate()
	{
		trace("Hi!");
	}
	
}