package ;

import haxe.xml.Fast;
import openfl.Assets;

/**
 * A piece of dialogue in the world that the player triggers by walking over it
 * @author Jakob
 */
class Dialogue extends GameObject
{
	public var conversation:Fast;

	/**
	 * loads the required conversation from the xml file
	 * @param	X
	 * @param	Y
	 * @param	Width
	 * @param	Height
	 * @param	dialogueID
	 */
	public function new(X:Float=0, Y:Float=0, Width:Float=0, Height:Float=0, dialogueID:String) 
	{
		super(X, Y, Width, Height);
		
		var xml:Xml = Xml.parse(Assets.getText("assets/data/bird.xml"));
		var dialogue = new Fast(xml.firstElement());
		for (conv in dialogue.elements)
		{
			if (conv.att.id == dialogueID)
			{
				conversation = conv;
				break;
			}
		}
		if (conversation == null)
		{
			trace("Error: conversation not found");
		}
	}
	
	/**
	 * calls the respective dialogue
	 */
	public override function activate()
	{
		Reg.ui.dialogueBox.displayDialogue(conversation);
		Reg.playState.currentLevel.triggers.remove(this);
	}
}