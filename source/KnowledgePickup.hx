package ;
import flixel.FlxSprite;

/**
 * ...
 * @author JJM
 */
class KnowledgePickup extends GameObject
{

	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0) 
	{
		super(X, Y, Width, Height);
		graphicComponent = new FlxSprite(X, Y, "sprites/pickup.png");
	}
	
	public override function activate()
	{
		trace("stuff");
		this.graphicComponent.kill();
		this.kill();
	}
	
}