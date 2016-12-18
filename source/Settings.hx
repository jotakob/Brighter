package ;

/**
 * Stores the settings that the player may be able to change in the future
 * @author Jakob
 */
class Settings
{
	public var jumpKeys:Array<String> = ["W", "UP", "SPACE"];
	public var leftKeys:Array<String> = ["A", "LEFT"];
	public var rightKeys:Array<String> = ["D", "RIGHT"];
	public var interactKeys:Array<String> = ["E", "ENTER"];
	public var menuKeys:Array<String> = ["M"];
	public var keyBindings = new Map<String, Array<String>>();
	public var gender:String = "male";
	public var playerName:String = "Max";
	public var musicVolume:Float = 1;
	public var soundVolume:Float = 1;
	
	public function new( ) 
	{
		var a:Int = 0;
	}
}