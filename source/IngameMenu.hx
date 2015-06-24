package ;

import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.plugin.MouseEventManager;
import flixel.FlxG;

/**
 * ...
 * @author JJM
 */
class IngameMenu extends FlxGroup
{
	private var isOpen:Bool = false;
	private var bgImage:FlxSprite;
	private var openStuff:FlxGroup = new FlxGroup();
	private var closedStuff:FlxGroup = new FlxGroup();

	public function new() 
	{
		super();
		
		bgImage = new FlxSprite(0, 0, AssetPaths.menuclosed__png);
		add(bgImage);
		
		var openButton = new FlxObject(5, 23, 77, 56);
		MouseEventManager.add(openButton, openButtonClick);
		add(openButton);
		
		var knowledgeButton = new FlxObject(0, 90, 86, 32);
		MouseEventManager.add(knowledgeButton, knowledgeButtonClick);
		openStuff.add(knowledgeButton);
		
		var mapButton = new FlxObject(0, 132, 86, 32);
		MouseEventManager.add(mapButton, mapButtonClick);
		openStuff.add(mapButton);
		
		var optionButton = new FlxObject(0, 144, 86, 32);
		MouseEventManager.add(optionButton, optionButtonClick);
		openStuff.add(optionButton);
		
		var saveButton = new FlxObject(0, 176, 86, 32);
		MouseEventManager.add(saveButton, saveButtonClick);
		openStuff.add(saveButton);
		
		var menuButton = new FlxObject(0, 208, 86, 32);
		MouseEventManager.add(menuButton, menuButtonClick);
		openStuff.add(menuButton);
	}
	
	private function openButtonClick(obj:FlxObject)
	{
		trace("making menu");
		if (isOpen)
		{
			remove(openStuff);
			bgImage.loadGraphic(AssetPaths.menuclosed__png);
			Reg.player.setMovable();
		}
		else
		{
			Reg.player.movable = false;
			add(openStuff);
			bgImage.loadGraphic(AssetPaths.menu__png);
		}
	}
	
	private function knowledgeButtonClick(obj:FlxObject)
	{
		Reg.ui.knowledgeBox.show(1);
	}
	
	private function mapButtonClick(obj:FlxObject)
	{
		trace("WIP");
	}
	
	private function optionButtonClick(obj:FlxObject)
	{
		trace("WIP");
	}
	
	private function saveButtonClick(obj:FlxObject)
	{
		trace("WIP");
	}
	
	private function menuButtonClick(obj:FlxObject)
	{
		FlxG.switchState(new MenuState());
	}
}