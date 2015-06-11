package ;

import flixel.group.FlxGroup;

/**
 * This class contains the different pieces of the user interface
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