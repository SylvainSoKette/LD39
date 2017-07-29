package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author SoKette
 */
class Light extends FlxSprite 
{

	public function new(X:Float=0, Y:Float=0, color:FlxColor) 
	{
		super(X, Y);
		this.makeGraphic(Blackboard.TILE_WIDTH, Blackboard.TILE_HEIGHT, color);
	}
	
}