package;

import flixel.FlxState;
import flixel.util.FlxSave;
import openfl.display.Stage;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static var settings = new Settings();
	
	public static var currentState:PlayState;
	public static var player:Player;
	public static var ui:UserInterface;
	
	public static var levels:Array<Dynamic> = [];
	public static var level:Int = 0;
	
	public static var scores:Array<Dynamic> = [];
	public static var score:Int = 0;
	
	public static var saves:Array<FlxSave> = [];
}