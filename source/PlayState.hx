package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var player:Player;
	public var currentLevel:TiledLevel;
	public var floor:FlxObject;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		//FlxG.mouse.visible = false;
		
		super.create();
		Reg.currentState = this;
		
		currentLevel = new TiledLevel("assets/levels/level.tmx");
		currentLevel.loadLevel(this);
		add(currentLevel.allStuff);
		
		player = new Player();
		player.x = currentLevel.getStartPoint()[0];
		player.y = currentLevel.getStartPoint()[1];
		add(player);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		// Collide with foreground tile layer
		currentLevel.collideWithLevel(player);
		
		if (FlxG.overlap(player, floor))
		{
			FlxG.resetState();
		}
	}	
}