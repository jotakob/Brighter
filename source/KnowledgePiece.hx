package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import haxe.xml.Fast;
import openfl.Assets;

/**
 * ...
 * @author JJM
 */
class KnowledgePiece extends FlxSprite
{
	public var longInfo:String;
	public var shortInfo:String;
	public var knowledgeID:Int;

	public function new(_knowledgeID:Int) 
	{
		knowledgeID = _knowledgeID;
		super(0, 0);
		var xml:Xml = Xml.parse(Assets.getText("assets/data/knowledge-" + knowledgeID + ".xml"));
		var text = new Fast(xml.firstElement());
		shortInfo = text.node.short.innerData;
		longInfo = text.node.long.innerData;
	}
	
	public function show()
	{
		trace(longInfo);
	}
}