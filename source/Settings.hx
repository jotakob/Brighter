package ;

/**
 * ...
 * @author JJM
 */
class Settings
{
	public var jumpKeys:Array<String> = ["W", "UP", "SPACE"];
	public var leftKeys:Array<String> = ["A", "LEFT"];
	public var rightKeys:Array<String> = ["D", "RIGHT"];
	public var interactKeys:Array<String> = ["E", "ENTER"];
	public var menuKeys:Array<String> = ["ESCAPE", "M"];
	public var keyBindings = new Map<String, Array<String>>();
	public var gender:String = "male";
	public var playerName:String = "Max";
	
	public function new() 
	{
		
	}
	
	public function loadSettings()
	{
		
	}
}