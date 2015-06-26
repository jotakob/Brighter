package ;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxMath;
import haxe.Timer;

/**
 * the knowledge piece in the level that the player can pick up
 * @author Jakob
 */
class KnowledgePickup extends GameObject
{
	public var knowledgeID:Int;
	private var text:FlxText;
	private var updating:Bool = false;

	public function new(X:Float=0, Y:Float=0, _knowledgeID:Int)
	{
		knowledgeID = _knowledgeID;
		super(X, Y, 16, 32);
		graphicComponent = new FlxSprite(X, Y, "sprites/pickup-" + knowledgeID + ".png");
		this.width = graphicComponent.width;
		this.height = graphicComponent.height;
	}
	
	/**
	 * adds the knowledge piece to the "inventory", displays the short info text and makes the pickup disappear
	 */
	public override function activate()
	{
		Reg.playState.currentLevel.triggers.remove(this);
		graphicComponent.destroy();
		Reg.sounds[0].play();
		var knowledge = new KnowledgePiece(knowledgeID);
		Reg.knowledgePieces.set(knowledgeID, knowledge);
		text = new FlxText(0, 0, FlxG.width - 96, knowledge.shortInfo);
		text.scrollFactor.set();
		text.setFormat(null, 8, 0xFFFFFF, "center");
		text.x = FlxG.width / 2 - text.width / 2;
		text.y = FlxG.height / 2 - text.height - 16;
		Reg.playState.add(this);
		Reg.ui.add(text);
		updating = true;
	}
	
	/**
	 * makes the text disappear after a certain distance
	 */
	public override function update()
	{
		if (updating)
		{
			super.update();
			if (FlxMath.getDistance(Reg.player.getMidpoint(), this.getMidpoint()) >= 64)
			{
				Reg.ui.remove(text);
				text.destroy();
				this.destroy();
			}
		}
	}
}