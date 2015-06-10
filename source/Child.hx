package ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import haxe.Timer;
import openfl.Assets;
import haxe.xml.Fast;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Jakob
 */
class Child extends GameObject
{
	public var imagePath:String;
	
	public var dialogue:Fast;
	
	public static inline var NOT_MET:String = "notmet";
	public static inline var MET:String = "met";
	public static inline var NO_HELP:String = "nohelp";
	public static inline var YES_HELP:String = "yeshelp";
	public static inline var WRONG_ANSWER:String = "wronganswer";
	public static inline var RIGHT_ANSWER:String = "rightanswer";
	public static inline var SOLVED:String = "solved";
	
	private var name:String;
	private var childID:Int;
	private var status:String = NOT_MET;
	private var currentConversation:Dynamic;
	

	public function new(X:Float=0, Y:Float=0, _ID:Int) 
	{
		super(X, Y, 32, 32);
		
		childID = _ID;
		graphicComponent = new FlxSprite(X, Y);
		graphicComponent.loadGraphic("sprites/child-" + childID + ".png", false, 64, 64, true);
		graphicComponent.animation.add("side", [1], 0 , false);
		graphicComponent.animation.add("front", [2], 0 , false);
		graphicComponent.animation.add("back", [3], 0 , false);
		graphicComponent.setFacingFlip(FlxObject.LEFT, true, false);
		graphicComponent.setFacingFlip(FlxObject.RIGHT, false, false);
		updateGraphics(FlxObject.UP);
		
		var xml:Xml = Xml.parse(Assets.getText("assets/data/child-" + childID + ".xml"));
		dialogue = new Fast(xml.firstElement());
	}
	
	public function updateGraphics(facing:Int = null)
	{
		if (facing != null)
		{
			graphicComponent.facing = facing;
		}
		else
		{
			facing = graphicComponent.facing;
		}
		
		if (facing == FlxObject.RIGHT || facing == FlxObject.LEFT)
		{
			graphicComponent.animation.play("side");
		}
		else 
		{
			graphicComponent.animation.play("front");
		}
		graphicComponent.x = this.x - 16;
		graphicComponent.y = this.y - 32;
	}
	
	public override function activate()
	{
		for (conv in dialogue.elements)
		{
			if (conv.att.id == status)
			{
				trace(conv.x);
				displayDialogue(conv);
				
				break;
			}
			else
			{
				trace("Error: Requested conversation not found");
			}
		}
	}
	
	public function onKeyDown(e:KeyboardEvent)
	{
		if (e.keyCode == Keyboard.ENTER || FlxG.keys.anyJustPressed(Reg.settings.interactKeys))
		{
			if (currentConversation.hasNext())
			{
				var text:Fast = currentConversation.next();
				Reg.ui.dialogue.setText(text.innerData, text.att.speaker);
			}
			else 
			{
				switch status
				{
					case NOT_MET, WRONG_ANSWER, NO_HELP:
						status = MET;
						continueGame();
						
					case MET:
						//TODO Choice box
						continueGame();
						
					case YES_HELP:
						//TODO Knowledge choice
						continueGame();
						
					case SOLVED:
						continueGame();
				}
			}
		}
	}
	
	private function continueGame()
	{
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Reg.ui.dialogue.hide();
		Timer.delay(Reg.player.setMovable, 50);
	}
	
	private function displayDialogue(conversation:Fast)
	{
		currentConversation = conversation.elements;
		var text:Fast = currentConversation.next();
		Reg.ui.dialogue.setText(text.innerData, text.att.speaker);
		Reg.player.movable = false;
		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
}