package ;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.group.FlxTypedGroup;
import flixel.plugin.MouseEventManager;
import flixel.ui.FlxButton;

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
	
	public var width:Int = 192;
	public var height:Int;
	public var x:Int;
	public var y:Int = 48;
	
	public var knowledgeAmount = 3;
	
	private var scrolls:FlxTypedGroup<FlxSprite>;
	private var closeButton:FlxButton;

	public function new()
	{
		super();
		
		height = FlxG.height - 96;
		x = FlxG.width - 240;
		background = new FlxSprite(x, y);
		background.scrollFactor.set();
		//background.x = x;
		//background.y = y;
		background.height = height;
		background.width = width;
		background.makeGraphic(width, height, 0xCC3B2508);
		add(background);
		
		//temp only
		closeButton = new FlxButton(0, 0, "Close", continueGame);
		closeButton.scrollFactor.set();
		add(closeButton);
	}
	
	public function show(_status:Int)
	{
		status = _status;
		scrolls = new FlxTypedGroup<FlxSprite>();
		
		for (i in 1...(knowledgeAmount + 1))
		{
			if (Reg.knowledgePieces.exists(i))
			{
				var kPiece = new FlxSprite(0, 0);
				kPiece.scrollFactor.set();
				kPiece.x = this.x;
				kPiece.y =  this.y + 48 * (i - 1);
				kPiece.makeGraphic(192, 44, 0xFFFFFFFF);
				kPiece.ID = i;
				scrolls.add(kPiece);
				MouseEventManager.add(kPiece, scrollClick);
			}
		}
		
		this.add(scrolls);
		
		Reg.ui.add(this);
	}
	
	private function scrollClick(obj:FlxObject)
	{
		Reg.knowledgePieces.get(obj.ID).show(status);
	}
	
	private function continueGame()
	{
		this.remove(scrolls);
		Reg.currentState.ui.remove(this);
		Reg.player.setMovable();
	}
}