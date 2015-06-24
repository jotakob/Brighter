package ;

import flixel.FlxSprite;
import haxe.xml.Fast;
import openfl.Assets;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextFormat;
import flixel.ui.FlxButton;
import flixel.FlxG;

/**
 * ...
 * @author JJM
 */
class KnowledgePiece extends FlxGroup
{
	
	public var longInfo:String;
	public var shortInfo:String;
	public var knowledgeID:Int;
	
	private var background:FlxSprite;
	private var text:FlxText;
	private var backButton:FlxButton;
	private var selectButton:FlxButton;
	
	private var kBox:KnowledgeBox;

	public function new(_knowledgeID:Int) 
	{
		knowledgeID = _knowledgeID;
		kBox = Reg.ui.knowledgeBox;
		super();
		var xml:Xml = Xml.parse(Assets.getText("assets/data/knowledge-" + knowledgeID + ".xml"));
		var fast = new Fast(xml.firstElement());
		shortInfo = fast.node.short.innerData;
		longInfo = fast.node.long.innerData;
		
		background = new FlxSprite(32, kBox.y - 16, AssetPaths.knowledge_expanded__png);
		background.scrollFactor.set();
		add(background);
		
		text = new FlxText(background.x + 14, background.y + 16, 292, longInfo);
		text.setFormat(Assets.getFont("assets/fonts/Artifika-Regular.ttf").fontName, 8, 0x000000, "center");
		text.scrollFactor.set();
		add(text);
		
		backButton = new FlxButton(background.x + 16, background.y + background.height - 8, "Back", hide);
		backButton.scrollFactor.set();
		add(backButton);
		
		selectButton = new FlxButton(0, background.y + background.height - 8, "Select", select);
		selectButton.scrollFactor.set();
		selectButton.x = background.x + background.width - selectButton.width - 16;
		
		// Assets.getFont("assets/fonts/Artifika-Regular.ttf").fontName
	}
	
	public function show(status:Int)
	{
		if (status == 2)
		{
			add(selectButton);
		}
		kBox.add(this);
	}
	
	private function hide()
	{
		kBox.remove(this);
	}
	
	private function select()
	{
		remove(selectButton);
		hide();
		kBox.hide();
		Reg.ui.dialogueBox.choiceDone(knowledgeID);
	}
}