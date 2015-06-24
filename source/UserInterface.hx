package ;

import flixel.FlxBasic;
import flixel.group.FlxGroup;

/**
 * This class contains the different pieces of the user interface
 * @author JJM
 */
class UserInterface extends FlxGroup
{
	public var dialogueBox:DialogueBox;
	public var knowledgeBox:KnowledgeBox;
	public var menu:IngameMenu;

	public function new()
	{
		super();
		dialogueBox = new DialogueBox();
		knowledgeBox = new KnowledgeBox();
		menu = new IngameMenu();
		add(menu);
	}
}