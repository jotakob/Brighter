package ;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.plugin.MouseEventManager;

/**
 * ...
 * @author ...
 */
class EndScreen extends FlxState
{

	/*public function new() 
	{
		super();
	}*/
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		bgColor = 0xFF000000;
		var img = new FlxSprite(0, 0);
		img.makeGraphic(384, 288, 0xFF000000);
		add(img);
		MouseEventManager.add(img, kjrwImage);
		var text = new FlxText(0, 0, 384, "Thanks for Playing\n\nBedankt voor het Spelen", 24);
		text.setFormat(null, 24, 0xFFFFFF, "center");
		text.y = FlxG.height / 2 - text.height / 2;
		add(text);
	}
	
	function kjrwImage(obj:FlxSprite)
	{
		MouseEventManager.remove(obj);
		var img = new FlxSprite(0, 0, AssetPaths.endscreen__png);
		add(img);
		MouseEventManager.add(img, toMain);
	}
	
	function toMain(obj:FlxSprite)
	{
		MouseEventManager.remove(obj);
		FlxG.switchState(new MenuState());
	}
}