package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author SoKette
 */
class Nuclearlight extends FlxSprite 
{	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		this.makeGraphic(Blackboard.TILE_WIDTH, Blackboard.TILE_HEIGHT, FlxColor.fromRGB(123, 255, 123, 20));
	}
	
	override public function update(elapsed:Float):Void {
		// this is shit, but it works AHAH (no idea why)
		if (this.alpha < 1) {
			this.alpha += 0.1;
		} else {
			this.alpha = 0.2;
		}
		
		super.update(elapsed);
	}
}