package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
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
	public var dialogue:DialogueBox;
	public var ui:FlxGroup = new FlxGroup();
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		
		super.create();
		Reg.currentState = this;
		
		player = new Player();
		Reg.player = player;
		newLevel("demo");
		dialogue = new DialogueBox();
		ui.add(dialogue);
	}
	
	public function newLevel(levelName:String)
	{
		remove(player);
		remove(ui);
		if (currentLevel != null)
		{
			remove(currentLevel.backgroundStuff);
			remove(currentLevel.foregroundStuff);
		}
		currentLevel = new TiledLevel("assets/levels/" + levelName + ".tmx");
		currentLevel.loadLevel();
		player.x = currentLevel.startPoint.x;
		player.y = currentLevel.startPoint.y;
		add(currentLevel.backgroundStuff);
		add(player);
		add(player.graphicComponent);
		add(currentLevel.foregroundStuff);
		add(ui);
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
		
		if (FlxG.overlap(player, currentLevel.floor))
		{
			player.x = currentLevel.startPoint.x;
			player.y = currentLevel.startPoint.y;
		}
	}	
}