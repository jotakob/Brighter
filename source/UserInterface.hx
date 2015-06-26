package ;

import flixel.FlxBasic;
import flixel.group.FlxGroup;

/**
 * This class contains the different pieces of the user interface, mostly for easier reference
 * @author Jakob
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
		knowledgeBox = new KnowledgeBox(); //Not a part of the menu, since it appears independently when selecting a piece for a child
		menu = new IngameMenu();
		menu.kBox = knowledgeBox;
		add(menu);
	}
}