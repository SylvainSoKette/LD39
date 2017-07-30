package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

/**
 * ...
 * @author SoKette
 */
class Timmy extends FlxSprite 
{
	private var _grabbed:Bool;
	private var _sndHey:FlxSound;
	
	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		
		//this.makeGraphic(Blackboard.TILE_WIDTH, Blackboard.TILE_HEIGHT, FlxColor.YELLOW);
		
		this.loadGraphic(AssetPaths.timmy__png, true, 16, 16);
		this.animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7], 6, true);
		
		this.setSize(Blackboard.TILE_WIDTH - 2, Blackboard.TILE_HEIGHT - 2);
		this.offset.set(1, 2);
		
		this.acceleration.y = 800; // timmy can fall too !
		
		this._grabbed = false;
		
		_sndHey = FlxG.sound.load(AssetPaths.hey__ogg);
		_sndHey.volume = 0.5;
	}
	
	override public function update(elapsed:Float):Void {
		animation.play("idle");
		
		super.update(elapsed);
	}
	
	public function moveTimmy(X:Float, Y:Float) {
		this.x = X;
		this.y = Y;
	}
	
	public function grab():Void {
		this._grabbed = true;
		this.acceleration.y = 0;
		_sndHey.play();
	}
	
	public function drop():Void {
		this._grabbed = false;
		this.acceleration.y = 800;
	}
	
	public function isGrabbed():Bool {
		return _grabbed;
	}
}