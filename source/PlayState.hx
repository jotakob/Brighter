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
		super.create();
		Reg.currentState = this;
		
		Reg.knowledgePieces = new Map<Int, KnowledgePiece>();
		Reg.levels = new Map<String, TiledLevel>();
		
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
	public function newLevel(newLevelName:String)
	{
		remove(player);
		player.kill();
		remove(ui);
		if (currentLevel != null)
		{
			remove(currentLevel.backgroundStuff);
			remove(currentLevel.foregroundStuff);
		}
		trace("Time spent in " + levelName + ": " + Math.floor((Lib.getTimer() - lastTime) / 1000) + "s");
		
		if (Reg.levels.exists(newLevelName))
		{
			currentLevel = Reg.levels.get(newLevelName);
		}
		else
		{
			currentLevel = new TiledLevel("assets/levels/" + newLevelName + ".tmx");
			currentLevel.levelName = newLevelName;
			currentLevel.loadLevel();
			Reg.levels.set(newLevelName, currentLevel);
		}
		
		var found = false;
		for (point in currentLevel.exitPoints)
		{
			if (point.name == levelName)
			{
				player.reset(point.x, point.y);
				found = true;
				break;
			}
		}
		if (!found)
		{
			player.reset(currentLevel.startPoint.x, currentLevel.startPoint.y);
		}
		
		levelName = newLevelName;
		FlxG.camera.setBounds(0, 0, currentLevel.fullWidth, currentLevel.fullHeight, true);
		
		lastTime = Lib.getTimer();
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
		//ui.update();
		
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