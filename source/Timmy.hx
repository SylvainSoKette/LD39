package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author SoKette
 */
class Timmy extends FlxSprite 
{
	private var _grabbed:Bool;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		this.makeGraphic(Blackboard.TILE_WIDTH, Blackboard.TILE_HEIGHT, FlxColor.YELLOW);
		this.setSize(Blackboard.TILE_WIDTH - 2, Blackboard.TILE_HEIGHT - 2);
		this.offset.set(1, 2);
		
		this.acceleration.y = 800; // timmy can fall too !
		
		this._grabbed = false;
	}
	
	public function moveTimmy(X:Float, Y:Float) {
		this.x = X;
		this.y = Y;
	}
	
	public function grab():Void {
		this._grabbed = true;
		this.acceleration.y = 0;
	}
	
	public function drop():Void {
		this._grabbed = false;
		this.acceleration.y = 800;
	}
	
	public function isGrabbed():Bool {
		return _grabbed;
	}
}