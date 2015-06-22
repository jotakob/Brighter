package ;

import flixel.FlxBasic;
import flixel.group.FlxGroup;

/**
 * This class contains the different pieces of the user interface
 * @author JJM
 */
class UserInterface extends FlxGroup
{
	public var dialogue:DialogueBox;
	public var knowledgeBox:KnowledgeBox;

	public function new()
	{
		super();
		dialogue = new DialogueBox();
	}
	
	public function showKnowledge(_status:Int)
	{
		knowledgeBox.status = _status;
		add(knowledgeBox);
	}
}