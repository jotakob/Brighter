package ;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.plugin.MouseEventManager;

/**
 * ...
 * @author JJM
 */
class KnowledgeBox extends FlxGroup
{
	public var background:FlxSprite;
	
	/**
	 * Current Status. 0: invisible, 1: reading, 2: selecting
	 */
	public var status:Int;
	
	private var width:Int = 192;
	private var height:Int;
	private var x:Int;
	private var y:Int = 48;
	
	private var knowledgeAmount = 3;

	public function new()
	{
		super();
		
		height = FlxG.height - 96;
		x = FlxG.width - 240;
		background = new FlxSprite(x, y);
		background.scrollFactor.set();
		background.x = x;
		background.y = y;
		background.height = height;
		background.width = width;
		background.makeGraphic(width, height, 0xCC3B2508);
		add(background);
	}
	
	private function scrollClick(obj:FlxObject)
	{
		Reg.knowledgePieces.get(obj.ID).show();
	}
	
	public function show(_status:Int)
	{
		for (i in 1...(knowledgeAmount + 1))
		{
			if (Reg.knowledgePieces.exists(i))
			{
				trace("making pieceasd");
				var kPiece = new FlxSprite(0, 0);
				kPiece.scrollFactor.set();
				kPiece.x = this.x;
				kPiece.y =  this.y + 48 * (i - 1);
				kPiece.makeGraphic(192, 44, 0xFFFFFFFF);
				kPiece.ID = i;
				this.add(kPiece);
				MouseEventManager.add(kPiece, scrollClick);
			}
		}
		
		Reg.ui.add(this);
	}
}