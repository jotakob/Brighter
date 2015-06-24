package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.plugin.MouseEventManager;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var state1:FlxGroup = new FlxGroup();
	private var state2:FlxGroup = new FlxGroup();
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		this.bgColor = 0xFF91A3EB;
		
		var startButton = new FlxButton(0, 100, "Start", startButtonClick);
		startButton.x = FlxG.width / 2 - startButton.width / 2;
		state1.add(startButton);
		
		var exitButton = new FlxButton(0, 200, "Quit", exitButtonClick);
		exitButton.x = FlxG.width / 2 - exitButton.width / 2;
		state1.add(exitButton);
		
		var maleButton = new FlxButton(0, 130, "Male");
		maleButton.x = FlxG.width / 2 - maleButton.width / 2;
		MouseEventManager.add(maleButton, genderButtonClick);
		state2.add(maleButton);
		
		var femaleButton = new FlxButton(0, 170, "Female");
		femaleButton.x = FlxG.width / 2 - femaleButton.width / 2;
		MouseEventManager.add(femaleButton, genderButtonClick);
		state2.add(femaleButton);
		
		var backButton = new FlxButton(0, 250, "Back", backButtonClick);
		backButton.x = FlxG.width / 2 - backButton.width / 2;
		state2.add(backButton);
		
		this.add(state1);
	}
	
	function startButtonClick()
	{
		remove(state1);
		add(state2);
	}
	
	function exitButtonClick()
	{
		Sys.exit(0);
	}
	
	function genderButtonClick(button:FlxButton)
	{
		Reg.settings.gender = button.text.toLowerCase();
		FlxG.switchState(new PlayState());
	}
	
	function backButtonClick()
	{
		remove(state2);
		add(state1);
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
	}	
}