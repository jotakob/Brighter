package ;

import flixel.group.FlxGroup;

/**
 * ...
 * @author JJM
 */
class UserInterface extends FlxGroup
{
	public var dialogue:DialogueBox;

	public function new() 
	{
		super();
		dialogue = new DialogueBox();
	}
	
}