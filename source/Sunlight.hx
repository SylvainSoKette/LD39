package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author SoKette
 */
class Sunlight extends FlxSprite 
{
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		this.makeGraphic(Blackboard.TILE_WIDTH, Blackboard.TILE_HEIGHT, FlxColor.fromRGB(255, 255, 153, 32));
		this.alpha = 0.2;
	}
}