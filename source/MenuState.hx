package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.plugin.MouseEventManager;
import haxe.Timer;
import openfl.Lib;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var state1:FlxGroup = new FlxGroup();
	private var state2:FlxGroup = new FlxGroup();
	private var state3:FlxGroup = new FlxGroup();
	
	var maleButton:FlxSprite;
	var femaleButton:FlxSprite;
	var clouds:FlxSprite;
	var title:FlxSprite;
	var music:FlxSound;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		music = new FlxSound();
		music.loadStream(AssetPaths.mainmenu__ogg, true);
		music.volume = 1;
		music.play();
		
		clouds = new FlxSprite(0, 0, AssetPaths.movingclouds__png);
		clouds.velocity.set(-24, 0);
		add(clouds);
		
		var bgImage = new FlxSprite(0, 0, AssetPaths.mainmenu__png);
		add(bgImage);
		
		title = new FlxSprite(0, 15, AssetPaths.title__png);
		title.velocity.set(0, 6);
		add(title);
		
		var startButton = new FlxButton(0, 128, "Start", startButtonClick);
		startButton.x = FlxG.width / 2 - startButton.width / 2;
		state1.add(startButton);
		
		var optionsButton = new FlxButton(0, 155, "Opties", optionButtonClick);
		optionsButton.x = FlxG.width / 2 - optionsButton.width / 2;
		state1.add(optionsButton);
		
		maleButton = new FlxSprite(224, 209);
		maleButton.ID = 1;
		maleButton.loadGraphic(AssetPaths.characters__png, true, 64, 64);
		maleButton.animation.add("standing", [0], 0, true);
		maleButton.animation.add("walking", [1, 2, 3, 4], 6, true);
		maleButton.animation.play("standing");
		MouseEventManager.add(maleButton, genderButtonClick, null, genderButtonEnter, genderButtonLeave);
		state2.add(maleButton);
		
		femaleButton = new FlxSprite(96, 209);
		femaleButton.ID = 2;
		femaleButton.loadGraphic(AssetPaths.characters__png, true, 64, 64);
		femaleButton.animation.add("standing", [5], 0, true);
		femaleButton.animation.add("walking", [6, 7, 8, 9], 6, true);
		femaleButton.animation.play("standing");
		MouseEventManager.add(femaleButton, genderButtonClick, null, genderButtonEnter, genderButtonLeave);
		state2.add(femaleButton);
		
		this.add(state1);
	}
	
	function startButtonClick()
	{
		remove(state1);
		add(state2);
	}
	
	function optionButtonClick()
	{
		remove(state1);
		add(state3);
	}
	
	function genderButtonEnter(button:FlxSprite)
	{
		button.animation.play("walking");
	}
	
	function genderButtonLeave(button:FlxSprite)
	{
		button.animation.play("standing");
	}
	
	function genderButtonClick(button:FlxSprite)
	{
		if (button.ID == 1)
		{
			Reg.settings.gender = "male";
		}
		else
		{
			Reg.settings.gender = "female";
		}
		button.velocity.set(0, 64);
		MouseEventManager.remove(maleButton);
		MouseEventManager.remove(femaleButton);
	}
	
	function helpText()
	{
		var text = new FlxText(0, 0, 190, "Select a character to start playing");
		text.setFormat(null, 12, 0xca9a3c, "center");
		text.x = FlxG.width / 2 - text.width / 2;
		text.y = FlxG.height / 2;
		add(text);
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
		
		if (clouds.x <= -2134)
		{
			clouds.x = 0;
		}
		
		if (title.y > 15 || title.y < 10)
		{
			title.velocity.y = -title.velocity.y;
		}
		
		if (maleButton.y + 16 > FlxG.height || femaleButton.y + 12 > FlxG.height)
		{
			music.destroy();
			FlxG.switchState(new PlayState());
		}
	}	
}