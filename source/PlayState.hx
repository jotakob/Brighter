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
		
		player = new Player();
		newLevel("level1");
	}
	
	public function newLevel(levelName:String)
	{
		remove(player);
		if (currentLevel != null)
		{
			remove(currentLevel.backgroundTiles);
			remove(currentLevel.foregroundTiles);
		}
		currentLevel = new TiledLevel("assets/levels/" + levelName + ".tmx");
		currentLevel.loadLevel(this);
		player.x = currentLevel.getStartPoint()[0];
		player.y = currentLevel.getStartPoint()[1];
		add(currentLevel.backgroundTiles);
		add(player);
		add(currentLevel.foregroundTiles);
		add(player.graphicComponent);
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
			player.x = currentLevel.getStartPoint()[0];
			player.y = currentLevel.getStartPoint()[0];
		}
	}	
}