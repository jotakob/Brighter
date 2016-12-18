package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.input.mouse.FlxMouseEventManager;
import haxe.Timer;
import openfl.Lib;

/**
 * A FlxState which is used for the game's menu.
 */
class MenuState extends FlxState
{
	private var titleState:FlxGroup = new FlxGroup();
	private var selectionState:FlxGroup = new FlxGroup();
	private var optionsState:FlxGroup = new FlxGroup();
	
	var maleButton:FlxSprite;
	var femaleButton:FlxSprite;
	var musicButton:FlxButton;
	var soundButton:FlxButton;
	var clouds:FlxSprite;
	var title:FlxSprite;
	var music:FlxSound;
	var frameCounter:Int = 0;
	var counting = false;
	var continuing = false;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		//Background Image & Sound
		super.create();
		music = new FlxSound();
		music.loadStream(AssetPaths.mainmenu__ogg, true);
		music.volume = Reg.settings.musicVolume;
		music.play();
		
		clouds = new FlxSprite(0, 0, AssetPaths.movingclouds__png);
		clouds.velocity.set(-24, 0);
		add(clouds);
		
		var bgImage = new FlxSprite(0, 0, AssetPaths.mainmenu__png);
		add(bgImage);
		
		title = new FlxSprite(0, 15, AssetPaths.title__png);
		title.velocity.set(0, 6);
		add(title);
		
		//Main Title Screen
		var startButton = new FlxButton(0, 128, "Start", startButtonClick);
		startButton.x = FlxG.width / 2 - startButton.width / 2;
		titleState.add(startButton);
		
		/*var continueButton = new FlxButton(0, 155, "Voortzetten", continueButtonClick);
		continueButton.x = FlxG.width / 2 - continueButton.width / 2;
		if (Reg.playState != null)
		{
			titleState.add(continueButton);
		}*/
		
		var optionsButton = new FlxButton(0, 155, "Opties", optionButtonClick);
		optionsButton.x = FlxG.width / 2 - optionsButton.width / 2;
		titleState.add(optionsButton);
		
		//Character selection
		maleButton = new FlxSprite(224, 209);
		maleButton.ID = 1;
		maleButton.loadGraphic(AssetPaths.characters__png, true, 64, 64);
		maleButton.animation.add("standing", [0], 0, true);
		maleButton.animation.add("walking", [1, 2, 3, 4], 6, true);
		maleButton.animation.play("standing");
		FlxMouseEventManager.add(maleButton, genderButtonClick, null, genderButtonEnter, genderButtonLeave);
		selectionState.add(maleButton);
		
		femaleButton = new FlxSprite(96, 209);
		femaleButton.ID = 2;
		femaleButton.loadGraphic(AssetPaths.characters__png, true, 64, 64);
		femaleButton.animation.add("standing", [5], 0, true);
		femaleButton.animation.add("walking", [6, 7, 8, 9], 6, true);
		femaleButton.animation.play("standing");
		FlxMouseEventManager.add(femaleButton, genderButtonClick, null, genderButtonEnter, genderButtonLeave);
		selectionState.add(femaleButton);
		
		//Options Menu
		var backButton = new FlxButton(0, 128, "Terug", backButtonClick);
		backButton.x = FlxG.width / 2 - backButton.width / 2;
		optionsState.add(backButton);
		
		musicButton = new FlxButton(0, 165, "Muziek: AAN", musicButtonClick);
		musicButton.x = FlxG.width / 2 - musicButton.width / 2;
		if (Reg.settings.musicVolume == 0)
		{
			musicButton.text = "Muziek: UIT";
		}
		else
		{
			musicButton.text = "Muziek: AAN";
		}
		optionsState.add(musicButton);
		
		soundButton = new FlxButton(0, 192, "Geluid: AAN", soundButtonClick);
		soundButton.x = FlxG.width / 2 - soundButton.width / 2;
		if (Reg.settings.soundVolume == 0)
		{
			soundButton.text = "Geluid: UIT";
		}
		else
		{
			soundButton.text = "Geluid: AAN";
		}
		optionsState.add(soundButton);
		
		this.add(titleState);
	}
	
	/**
	 * switches to the character selection state. starts the counter for the hint.
	 */
	function startButtonClick()
	{
		remove(titleState);
		counting = true;
		continuing = false;
		add(selectionState);
	}
	
	function continueButtonClick()
	{
		remove(titleState);
		counting = true;
		continuing = true;
		add(selectionState);
	}
	
	/**
	 * switches to the options menu state
	 */
	function optionButtonClick()
	{
		remove(titleState);
		add(optionsState);
	}
	
	/**
	 * hover animation for the characters
	 * @param	button
	 */
	function genderButtonEnter(button:FlxSprite)
	{
		button.animation.play("walking");
	}
	function genderButtonLeave(button:FlxSprite)
	{
		button.animation.play("standing");
	}
	
	/**
	 * character selection. the selected character walks off screen
	 * @param	button
	 */
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
		button.velocity.set(0, 48);
		FlxMouseEventManager.remove(maleButton);
		FlxMouseEventManager.remove(femaleButton);
		music.fadeOut(1.5, 0);
	}
	
	/**
	 * displays a help text for the player
	 */
	function helpText()
	{
		var text = new FlxText(0, 0, 190, "Select a character to start playing");
		text.setFormat(null, 12, 0xca9a3c, "center");
		text.x = FlxG.width / 2 - text.width / 2;
		text.y = FlxG.height / 2;
		add(text);
	}
	
	/**
	 * switches back to the main menu state
	 */
	function backButtonClick()
	{
		remove(optionsState);
		add(titleState);
	}
	
	/**
	 * inverts the music volume and updates the button accordingly
	 */
	function musicButtonClick()
	{
		var value = Math.abs(Reg.settings.musicVolume - 1);
		Reg.settings.musicVolume = value;
		music.volume = value;
		if (value == 0)
		{
			musicButton.text = "Muziek: UIT";
		}
		else
		{
			musicButton.text = "Muziek: AAN";
		}
	}
	
	/**
	 * inverts the sound volume and updates the button accordingly
	 */
	function soundButtonClick()
	{
		var value = Math.abs(Reg.settings.soundVolume - 1);
		Reg.settings.soundVolume = value;
		if (value == 0)
		{
			soundButton.text = "Geluid: UIT";
		}
		else
		{
			soundButton.text = "Geluid: AAN";
		}
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
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		//moving the clouds
		if (clouds.x <= -2134)
		{
			clouds.x = 0;
		}
		
		//moving the game title text
		if (title.y > 15 || title.y < 10)
		{
			title.velocity.y = -title.velocity.y;
		}
		
		//displaying the helptext after a certain time
		if (counting)
		{
			frameCounter++;
			if (frameCounter == 400)
			{
				helpText();
			}
		}
		
		//When a character is off screen, starts the game
		if (maleButton.y + 16 > FlxG.height || femaleButton.y + 12 > FlxG.height)
		{
			music.destroy();
			if (continuing)
			{
				//FlxG.switchState(Reg.playState);
			}
			else
			{
				FlxG.switchState(new PlayState());
			}
		}
	}	
}