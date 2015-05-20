package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import openfl.Assets;

/**
 * ...
 * @author Jakob
 */
class Player extends FlxObject
{
	private var hasDoubleJumped:Bool = false;
	private var isJumping:Bool = false;
	private var lastOrientation:String = "left";
	private var orientation:String = "right";
	public var graphicComponent:FlxSprite = new FlxSprite();
	
	
	public function new() 
	{
		super(0, 0, 24, 32);
		
		loadAnimations();
		
		maxVelocity.x = 200;
		maxVelocity.y = 400;
		acceleration.y = 400;
		drag.y = -200;
		drag.x = maxVelocity.x * 4;
		FlxG.camera.follow(this);
	}
	
	public function loadAnimations()
	{
		graphicComponent.loadGraphic("sprites/char-" + Reg.gender + ".png", true, 64, 64, true);
		graphicComponent.animation.add("down", [0, 1, 2, 3], 6, true);
		graphicComponent.animation.add("up", [8, 9, 10, 11], 6, true);
		graphicComponent.animation.add("right", [16, 17, 18, 19, 20, 21, 22, 23], 6, true);
		graphicComponent.animation.add("left", [24, 25, 26, 27, 28, 29, 30, 31], 6, true);
		graphicComponent.drag.x = graphicComponent.drag.y = 1600;
	}
	
	public function jump()
	{
		isJumping = true;
		velocity.y = -250;
	}
	
	public override function update()
	{
		lastOrientation = orientation;
		
		if (this.isTouching(FlxObject.FLOOR))
		{
			hasDoubleJumped = false;
		}
		
		acceleration.x = 0;
		if (FlxG.keys.pressed.LEFT)
		{
			acceleration.x = -maxVelocity.x * 4;
			orientation = "left";
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			acceleration.x = maxVelocity.x * 4;
			orientation = "right";
		}
		if (FlxG.keys.anyJustPressed(["SPACE", "UP"]))
		{
			if (this.isTouching(FlxObject.FLOOR))
			{
				jump();
			}
			else if (!hasDoubleJumped)
			{
				if ( (FlxG.keys.pressed.LEFT && velocity.x == Math.abs(velocity.x)) || (FlxG.keys.pressed.RIGHT && velocity.x == -Math.abs(velocity.x)) )
				{
					velocity.x = 0;
				}
				jump();
				hasDoubleJumped = true;
			}
		}
		
		if (orientation != lastOrientation)
		{
			graphicComponent.animation.play("down"/*orientation*/);
		}
		
		graphicComponent.x = this.x - 20;
		graphicComponent.y = this.y - 32;
		
		super.update();
	}
	
}