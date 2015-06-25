package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import openfl.Assets;
import openfl.Lib;
import flixel.group.FlxTypedGroup;
import flixel.system.FlxSound;

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
	public var music:FlxSound;
	
	private var brightnessSprite:FlxSprite;
	private var brightnessLevel:Int = 0;
	private var brightnessColor:Int = 0x99111111;
	private var lastTime:Int = 0;
	public var playerPosition:FlxPoint = new FlxPoint();
	
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{		
		super.create();
		Reg.playState = this;
		
		music = new FlxSound();
		music.loadStream(AssetPaths.maingame__ogg, true);
		music.volume = Reg.settings.musicVolume;
		music.play();
		
		var sound = new FlxSound();
		sound.loadStream(AssetPaths.pickup__ogg);
		sound.volume = Reg.settings.soundVolume;
		Reg.sounds = new Array<FlxSound>();
		Reg.sounds.push(sound);
		
		Reg.knowledgePieces = new Map<Int, KnowledgePiece>();
		Reg.levels = new Map<String, TiledLevel>();
		Reg.childCounter = 0;
		brightnessSprite = new FlxSprite(0, 0);
		
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
		remove(brightnessSprite);
		if (currentLevel != null)
		{
			remove(currentLevel.backgroundStuff);
			remove(currentLevel.foregroundStuff);
		}
		//trace("Time spent in " + levelName + ": " + Math.floor((Lib.getTimer() - lastTime) / 1000) + "s");
		
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
		
		brightnessSprite.makeGraphic(currentLevel.fullWidth, currentLevel.fullHeight, brightnessColor);
		lastTime = Lib.getTimer();
		
		add(currentLevel.backgroundStuff);
		add(player);
		add(player.graphicComponent);
		add(currentLevel.foregroundStuff);
		add(brightnessSprite);
		add(ui);
	}
	
	public function makeBrighter()
	{
		brightnessLevel++;
		switch brightnessLevel
		{
			case -1:
				brightnessColor = 0x99222222;
			
			case 1:
				brightnessColor = 0x55444444;
				
			default:
				brightnessColor = 0x00ffffff;
		}
		
		brightnessSprite.makeGraphic(currentLevel.fullWidth, currentLevel.fullHeight, brightnessColor);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		music.destroy();
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
		
		if (currentLevel.levelName == "overworld")
		{
			playerPosition.x = player.x / currentLevel.fullWidth;
			playerPosition.y = player.y / currentLevel.fullHeight;
		}
	}
	
	function triggerObject(obj1:Dynamic, obj2:Dynamic)
	{
		cast(obj2, GameObject).activate();
	}
}