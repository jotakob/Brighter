package ;
import flixel.FlxSprite;

/**
 * ...
 * @author JJM
 */
class KnowledgePickup extends GameObject
{
	public var knowledgeID:Int;

	public function new(X:Float=0, Y:Float=0, _knowledgeID:Int) 
	{
		knowledgeID = _knowledgeID;
		super(X, Y);
		graphicComponent = new FlxSprite(X, Y, "sprites/pickup.png");
		this.width = graphicComponent.width;
		this.height = graphicComponent.height;
	}
	
	public override function activate()
	{
		this.graphicComponent.destroy();
		var knowledge = new KnowledgePiece(knowledgeID);
		Reg.knowledgePieces.set(knowledgeID, knowledge);
		this.destroy();
	}
	
}