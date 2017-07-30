package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.system.FlxSound;
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
	private var _blinkPower:Float = 3.5;
	
	private var _sndTurboJump:FlxSound;
	private var _sndTurbo:FlxSound;
	private var _sndHover:FlxSound;
	private var _sndMove:FlxSound;
	private var _sndBlink:FlxSound;
	
	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		
		//this.makeGraphic(Blackboard.TILE_WIDTH, Blackboard.TILE_HEIGHT, FlxColor.CYAN);
		this.loadGraphic(AssetPaths.robot__png, true, 16, 16);
		this.animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7], 6, true);
		this.animation.add("move", [8, 9, 10, 11, 12, 13, 14, 15], 6, true);
		
		this.setSize(Blackboard.TILE_WIDTH - 2, Blackboard.TILE_HEIGHT - 2);
		this.offset.set(1, 2);
		this.drag.x = this.drag.y = _moveSpeed * 16;
		this.acceleration.y = 800;
		this.maxVelocity.x = _moveSpeed;
		this.maxVelocity.y = 313;
		
		this._power = 1.0;
		
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		_sndTurboJump = FlxG.sound.load(AssetPaths.turbojump__wav);
		_sndTurbo = FlxG.sound.load(AssetPaths.turbo__wav);
		_sndHover = FlxG.sound.load(AssetPaths.hover2__wav);
		//_sndMove = FlxG.sound.load(AssetPaths.move__wav);
		_sndBlink = FlxG.sound.load(AssetPaths.blink2__wav);
		
		_sndHover.volume = 0.20;
	}
	
	override public function update(elapsed:Float):Void {
		cantGetOutOfMap();
		
		if (_power > 1.0) {
			_power = 1.0;
		}
		
		if (this.velocity.x != 0) {
			animation.play("move");
		} else {
			animation.play("idle");
		}
		
		super.update(elapsed);
		negativePowerNotAllowed();
	}
	
	public function moveLeft():Void {
		if (hasPowerLeft()) {
			this.acceleration.x = -this.drag.x;
			this.drainPower(0.0005);
			//_sndMove.play();
		}
		this.facing = FlxObject.LEFT;
		//this._direction = true;
	}
	
	public function moveRight():Void {
		if (hasPowerLeft()) {
			this.acceleration.x = this.drag.x;
			this.drainPower(0.0005);
			//_sndMove.play();
		}
		this.facing = FlxObject.RIGHT;
		//this._direction = false;
	}
	
	public function turbo():Void {
		if (hasPowerLeft()) {
			FlxG.camera.shake(0.005, 0.05);
			this.velocity.x *= 3;
			this.drainPower(0.0007);
			_sndTurbo.play();
		}
	}
	
	public function hover():Void {
		if (hasPowerLeft()) {
			FlxG.camera.shake(0.002, 0.05);
			this.velocity.y = -50;
			this.drainPower(0.002);
			_sndHover.play();
		}
	}
	
	public function turboJump():Void {
		if (hasPowerLeft()) {
			FlxG.camera.flash(FlxColor.ORANGE, 0.25);
			FlxG.camera.shake(0.025, 0.25);
			this.velocity.y = - this.maxVelocity.y;
			this.drainPower(0.1);
			_sndTurboJump.play();
		}
	}
	
	public function blink():Void {
		if (hasPowerLeft()) {
			FlxG.camera.flash(0xff0066ff, 0.5);
			if (this.facing == FlxObject.LEFT) {
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
			_sndBlink.play();
		}
	}
	
	public function getPower():Float {
		return this._power;
	}
	
	public function drainPower(amount:Float):Void {
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
}