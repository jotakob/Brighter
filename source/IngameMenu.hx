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
	
	private var mapImage:FlxSprite;
	private var mapMarker:FlxSprite;
	public var kBox:KnowledgeBox;
	private var optionsImage:FlxSprite;
	private var frameCounter:Int = 0;

	public function new()
	{
		super();
		
		bgImage = new FlxSprite(0, 0, AssetPaths.menuclosed__png);
		bgImage.scrollFactor.set();
		add(bgImage);
		
		var openButton = new FlxObject(0, 0, 80, 68);
		openButton.scrollFactor.set();
		MouseEventManager.add(openButton, openButtonClick);
		add(openButton);
		
		var knowledgeButton = new FlxObject(0, 73, 86, 32);
		knowledgeButton.scrollFactor.set();
		MouseEventManager.add(knowledgeButton, knowledgeButtonClick);
		openStuff.add(knowledgeButton);
		
		var mapButton = new FlxObject(0, 130, 115, 32);
		mapButton.scrollFactor.set();
		MouseEventManager.add(mapButton, mapButtonClick);
		openStuff.add(mapButton);
		
		var optionButton = new FlxObject(0, 157, 86, 32);
		optionButton.scrollFactor.set();
		MouseEventManager.add(optionButton, optionButtonClick);
		openStuff.add(optionButton);
		
		var saveButton = new FlxObject(0, 199, 86, 32);
		saveButton.scrollFactor.set();
		MouseEventManager.add(saveButton, saveButtonClick);
		openStuff.add(saveButton);
		
		var menuButton = new FlxObject(0, 241, 86, 32);
		menuButton.scrollFactor.set();
		MouseEventManager.add(menuButton, menuButtonClick);
		openStuff.add(menuButton);
		
		mapImage = new FlxSprite(0, 0, AssetPaths.map__png);
		mapImage.scrollFactor.set();
		mapImage.x = FlxG.width - mapImage.width - 10;
		mapImage.y = FlxG.height / 2 - mapImage.height / 2;
		
		mapMarker = new FlxSprite(0, 0);
		mapMarker.scrollFactor.set();
		mapMarker.makeGraphic(3, 3, 0xFFFF0000);
		
		optionsImage = new FlxSprite(FlxG.width - 240, 48, AssetPaths.options__png);
		optionsImage.scrollFactor.set();
		
	}
	
	private function openButtonClick(obj:FlxObject)
	{
		if (isOpen)
		{
			remove(openStuff);
			bgImage.loadGraphic(AssetPaths.menuclosed__png);
			Reg.player.setMovable();
			isOpen = false;
		}
		else if (Reg.player.movable)
		{
			Reg.player.movable = false;
			add(openStuff);
			bgImage.loadGraphic(AssetPaths.menu__png);
			isOpen = true;
		}
	}
	
	private function knowledgeButtonClick(obj:FlxObject)
	{
		if (kBox.status == 0)
		{
			closeAll();
			kBox.show(1);
		}
		else
		{
			kBox.hide();
		}
	}
	
	private function mapButtonClick(obj:FlxObject)
	{
		if (this.members.indexOf(mapImage) >= 0)
		{
			remove(mapImage);
			remove(mapMarker);
		}
		else
		{
			closeAll();
			mapMarker.x = mapImage.x + Reg.playState.playerPosition.x * mapImage.width;
			mapMarker.y = mapImage.y + Reg.playState.playerPosition.y * mapImage.height;
			add(mapImage);
			add(mapMarker);
		}
	}
	
	private function optionButtonClick(obj:FlxObject)
	{
		if (this.members.indexOf(optionsImage) >= 0)
		{
			remove(optionsImage);
		}
		else
		{
			closeAll();
			add(optionsImage);
		}
	}
	
	private function saveButtonClick(obj:FlxObject)
	{
		//trace("WIP");
	}
	
	private function menuButtonClick(obj:FlxObject)
	{
		FlxG.switchState(new MenuState());
	}
	
	private function closeAll()
	{
		kBox.hide();
		remove(mapImage);
		remove(mapMarker);
		remove(optionsImage);
	}
	
	public override function update()
	{
		super.update();
		frameCounter++;
		if (frameCounter > 30)
		{
			mapMarker.visible = !mapMarker.visible;
			frameCounter = 0;
		}
	}
}