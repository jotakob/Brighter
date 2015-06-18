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
	public static var currentChild:Child;
	public static var knowledgePieces:Map<Int, KnowledgePiece> = new Map<Int, KnowledgePiece>();
	
	public static var levels:Map<String, TiledLevel> = new Map<String, TiledLevel>();
	
	public static var saves:Array<FlxSave> = [];
}