package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author SoKette
 */
class Player extends FlxSprite 
{
	private var _jumpPower:Int = 32;
	private var _moveSpeed:Int = 80;
	private var _power:Float;
	private var _direction:Bool;
	private var _blinkPower:Float = 3.5;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		this.makeGraphic(Blackboard.TILE_WIDTH, Blackboard.TILE_HEIGHT, FlxColor.CYAN);
		this.setSize(Blackboard.TILE_WIDTH - 2, Blackboard.TILE_HEIGHT - 2);
		this.offset.set(1, 2);
		this.drag.x = this.drag.y = _moveSpeed * 16;
		this.acceleration.y = 800;
		this.maxVelocity.x = _moveSpeed;
		this.maxVelocity.y = 200;
		
		this._direction = true; // true is left, false is right
		this._power = 1.0;
	}
	
	override public function update(elapsed:Float):Void {
		cantGetOutOfMap();
		super.update(elapsed);
		negativePowerNotAllowed();
	}
	
	public function moveLeft():Void {
		if (hasPowerLeft()) {
			this.acceleration.x = -this.drag.x;
			this.drainPower(0.0005);
		}
		this._direction = true;
	}
	
	public function moveRight():Void {
		if (hasPowerLeft()) {
			this.acceleration.x = this.drag.x;
			this.drainPower(0.0005);
		}
		this._direction = false;
	}
	
	public function turbo():Void {
		if (hasPowerLeft()) {
			FlxG.camera.shake(0.005, 0.05);
			this.velocity.x *= 3;
			this.drainPower(0.001);	
		}
	}
	
	public function hover():Void {
		if (hasPowerLeft()) {
			FlxG.camera.shake(0.002, 0.05);
			this.velocity.y = -25;
			this.drainPower(0.001);
		}
	}
	
	public function turboJump():Void {
		if (hasPowerLeft()) {
			FlxG.camera.flash(FlxColor.ORANGE, 0.25);
			FlxG.camera.shake(0.025, 0.25);
			this.velocity.y = -this.maxVelocity.y;
			this.drainPower(0.1);
		}
	}
	
	public function blink():Void {
		if (hasPowerLeft()) {
			FlxG.camera.flash(0xff0066ff, 0.5);
			if (this._direction) {
				if (this.x > Blackboard.TILE_WIDTH * this._blinkPower + Blackboard.TILE_WIDTH) {
					this.x -= Blackboard.TILE_WIDTH * this._blinkPower;
				} else {
					this.x = 0;
				}
			} else {
				if (this.x < (Blackboard.TILE_WIDTH * Blackboard.MAP_WIDTH) - (Blackboard.TILE_WIDTH * this._blinkPower) - Blackboard.TILE_WIDTH) {
					this.x += Blackboard.TILE_WIDTH * this._blinkPower;
				} else {
					this.x = Blackboard.TILE_WIDTH * Blackboard.MAP_WIDTH - Blackboard.TILE_WIDTH;
				}
			}
			this.drainPower(0.2);
		}
	}
	
	public function getPower():Float {
		return this._power;
	}
	
	private function drainPower(amount:Float):Void {
		this._power -= amount;
	}
	
	private function hasPowerLeft():Bool {
		return (this._power > 0);
	}
	
	private function negativePowerNotAllowed():Void {
		if (!hasPowerLeft())
			this._power = 0;
	}
	
	private function cantGetOutOfMap():Void {
		var max_x:Int = Blackboard.TILE_WIDTH * Blackboard.MAP_WIDTH - Blackboard.TILE_WIDTH;
		if (this.x < 0)
			this.x = 0;
		if (this.x > (max_x))
			this.x = max_x;
	}
	
	//private function isOutside(): Void {
		//if (this.y > Blackboard.TILE_HEIGHT * 64) {
			//for (px in 0 ... this.x) {
				//if ()
			//}
		//}
	//}
}