package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;

/**
 * ...
 * @author Jakob
 */
class Player extends FlxSprite
{
	private var hasDoubleJumped:Bool = false;
	
	public function new() 
	{
		super();
		
		this.makeGraphic(32, 32, 0xffaa1111);
		maxVelocity.x = 160;
		maxVelocity.y = 400;
		acceleration.y = 400;
		drag.x = maxVelocity.x * 4;
		FlxG.camera.follow(this);
	}
	
	public override function update()
	{
		if (this.isTouching(FlxObject.FLOOR))
		{
			hasDoubleJumped = false;
		}
		
		acceleration.x = 0;
		if (FlxG.keys.pressed.LEFT)
		{
			acceleration.x = -maxVelocity.x * 4;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			acceleration.x = maxVelocity.x * 4;
		}
		if (FlxG.keys.anyJustPressed(["SPACE", "UP"]))
		{
			if (this.isTouching(FlxObject.FLOOR))
			{
				velocity.y = -250;
			}
			else if (!hasDoubleJumped)
			{
				if ( (FlxG.keys.pressed.LEFT && velocity.x == Math.abs(velocity.x)) || (FlxG.keys.pressed.RIGHT && velocity.x == -Math.abs(velocity.x)) )
				{
					velocity.x = 0;
				}
				velocity.y = -250;
				hasDoubleJumped = true;
			}
		}
		
		super.update();
	}
	
}