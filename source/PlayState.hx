package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import openfl.Assets;
import openfl.Lib;

/**
 * A FlxState which can be used for the actual gameplay.
 * @author Jakob
 */
class PlayState extends FlxState
{
	public var player:Player;
	public var currentLevel:TiledLevel;
	public var dialogue:DialogueBox;
	public var ui:UserInterface;
	public var levelName:String;
	
	private var lastTime:Int = 0;
	
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		
		super.create();
		Reg.currentState = this;
		
		ui = new UserInterface();
		Reg.ui = ui;
		
		player = new Player();
		Reg.player = player;
		newLevel("overworld");
	}
	
	/**
	 * Removes the current level and loads a new level
	 * @param	levelName The name of the level to be loaded
	 */
	public function newLevel(_levelName:String)
	{
		levelName = _levelName;
		remove(player);
		remove(ui);
		if (currentLevel != null)
		{
			remove(currentLevel.backgroundStuff);
			remove(currentLevel.foregroundStuff);
		}
		currentLevel = new TiledLevel("assets/levels/" + levelName + ".tmx");
		trace("loading level " + levelName + ", time spent in last level: " + Math.floor((Lib.getTimer() - lastTime)/1000) + "s");
		lastTime = Lib.getTimer();
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
		
		// Collide with foreground tile layer and other elements
		currentLevel.collideWithLevel(player);
		FlxG.overlap(player, currentLevel.triggers, triggerObject);
		
		if (FlxG.overlap(player, currentLevel.floor))
		{
			player.x = currentLevel.startPoint.x;
			player.y = currentLevel.startPoint.y;
		}
	}
	
	function triggerObject(obj1:Dynamic, obj2:Dynamic)
	{
		cast(obj2, GameObject).activate();
	}
}