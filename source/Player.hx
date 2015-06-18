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
	//Variables to keep track of the state of the player
	private var hasDoubleJumped:Bool = false;
	private var isJumping:Bool = false;
	private var isWalking:Bool = false;
	
	/**
	 * The Graphic of the player, to seperate hitbox from visuals.
	 */
	public var graphicComponent:FlxSprite = new FlxSprite();
	
	/**
	 * Whether the player is currently in control of the character.
	 */
	public var movable:Bool = true;
	
	
	public function new() 
	{
		super(0, 0, 20, 30);
		
		loadAnimations();
		
		maxVelocity.x = 200;
		maxVelocity.y = 600;
		acceleration.y = 400;
		drag.y = -200;
		drag.x = maxVelocity.x * 6;
		FlxG.camera.follow(this);
	}
	
	
	/**
	 * Loads the player spritesheet and the animations
	 */
	public function loadAnimations()
	{
		graphicComponent.loadGraphic("sprites/character-" + Reg.settings.gender + ".png", true, 64, 64, true);
		graphicComponent.animation.add("down", [0, 1, 2, 3], 6, true);
		graphicComponent.animation.add("up", [8, 9, 10, 11], 6, true);
		graphicComponent.animation.add("walk", [16, 17, 18, 19, 20, 21, 22, 23], 12, true);
		graphicComponent.animation.add("jump", [4, 5, 6, 7], 6, false);
		//graphicComponent.drag.x = graphicComponent.drag.y = 1600;
		graphicComponent.setFacingFlip(FlxObject.LEFT, true, false);
		graphicComponent.setFacingFlip(FlxObject.RIGHT, false, false);
	}
	
	public function jump()
	{
		isJumping = true;
		velocity.y = -188;
		graphicComponent.animation.getByName("walk").curFrame = 1;
		graphicComponent.animation.play("jump", true);
	}
	
	public function setMovable()
	{
		movable = true;
	}
	
	/**
	 * Deals mostly with player movement
	 */
	public override function update()
	{
		#if debug
		//CHEATS
		if (FlxG.keys.justPressed.BACKSPACE)
		{
			FlxG.resetState();
		}
		#end
		
		isWalking = this.isTouching(FlxObject.FLOOR);
		
		if (isWalking)
		{
			isJumping = false;
			hasDoubleJumped = false;
		}
		
		//Player movement
		acceleration.x = 0;
		if (movable)
		{
			if (FlxG.keys.anyPressed(Reg.settings.rightKeys))
			{
				acceleration.x = maxVelocity.x * 4;
				graphicComponent.facing = FlxObject.RIGHT;
			}
			if (FlxG.keys.anyPressed(Reg.settings.leftKeys))
			{
				acceleration.x = -maxVelocity.x * 4;
				graphicComponent.facing = FlxObject.LEFT;
			}
			if (FlxG.keys.anyJustPressed(Reg.settings.interactKeys))
			{
				FlxG.overlap(this, Reg.currentState.currentLevel.activatableObjects, activateObject);
			}
		}
		
		//Animating the player
		if (isWalking)
		{
			graphicComponent.animation.play("walk");
			if (velocity.x == 0)
			{
				graphicComponent.animation.pause();
			}
		}
		else if (!isJumping)
		{
			graphicComponent.animation.pause();
		}
		
		if (movable)
		{
			if (FlxG.keys.anyJustPressed(Reg.settings.jumpKeys))
			{
				if (this.isTouching(FlxObject.FLOOR))
				{
					jump();
				}
				else if (!hasDoubleJumped && Reg.currentState.levelName != "school")
				{
					if ( (FlxG.keys.pressed.LEFT && velocity.x == Math.abs(velocity.x)) || (FlxG.keys.pressed.RIGHT && velocity.x == -Math.abs(velocity.x)) )
					{
						velocity.x = 0;
					}
					jump();
					hasDoubleJumped = true;
				}
			}
		}
		
		graphicComponent.x = this.x - 22;
		graphicComponent.y = this.y - 34;
		
		super.update();
	}
	
	//Collide & Overlap functions
	private function activateObject(player:Dynamic, object:Dynamic)
	{
		cast(object, GameObject).activate();
	}
}