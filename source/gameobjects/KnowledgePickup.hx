package ;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;
import haxe.Timer;

/**
 * ...
 * @author JJM
 */
class KnowledgePickup extends GameObject
{
	public var knowledgeID:Int;
	private var text:FlxText;

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
		this.kill();
		graphicComponent.destroy();
		var knowledge = new KnowledgePiece(knowledgeID);
		Reg.knowledgePieces.set(knowledgeID, knowledge);
		text = new FlxText(0, 0, FlxG.width - 96, knowledge.shortInfo);
		text.scrollFactor.set();
		text.setFormat(null, 8, 0xFFFFFF, "center");
		text.x = FlxG.width / 2 - text.width / 2;
		text.y = FlxG.height / 2 - text.height - 16;
		trace(knowledge.shortInfo);
		Reg.ui.add(this);
		Timer.delay(delete, 2000);
	}
	
	public function delete()
	{
		text.destroy();
		this.destroy();
	}
}