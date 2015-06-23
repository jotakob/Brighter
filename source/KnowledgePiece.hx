package ;

import flixel.FlxSprite;
import haxe.xml.Fast;
import openfl.Assets;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextFormat;
import flixel.ui.FlxButton;

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
		
		background = new FlxSprite(kBox.x + 16, kBox.y - 16);
		background.scrollFactor.set();
		background.makeGraphic(160, 224, 0xFFFFFFFF);
		add(background);
		
		text = new FlxText(kBox.x + 16, kBox.y - 16, 160, longInfo, 10);
		text.addFormat(new FlxTextFormat(0x000000));
		text.alignment = "center";
		text.scrollFactor.set();
		add(text);
		
		backButton = new FlxButton(kBox.x, background.y + background.height - 8, "Back", hide);
		backButton.scrollFactor.set();
		add(backButton);
		
		selectButton = new FlxButton(0, background.y + background.height - 8, "Select", select);
		selectButton.scrollFactor.set();
		selectButton.x = kBox.x + kBox.width - selectButton.width;
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
	}
}