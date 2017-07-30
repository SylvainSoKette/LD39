package;

import Math;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import SkText;

/**
 * ...
 * @author SoKette
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
	private var _bgHUD:FlxSprite;
	private var _imgBattery:FlxSprite;
	private var _txtBattery:SkText;
	private var _txtWin:SkText;
	
	public function new() 
	{
		super();
		
		_bgHUD = new FlxSprite(0, 0, AssetPaths.HUD__png);
		add(_bgHUD);
		
		_imgBattery = new FlxSprite(221, 5);
		_imgBattery.makeGraphic(12, 5, FlxColor.WHITE);
		add(_imgBattery);
		
		_txtBattery = new SkText("", 8, false);
		_txtBattery.color = FlxColor.fromRGB(168, 32, 32, 255);
		add(_txtBattery);
		
		_txtWin = new SkText("", 16, true);
		_txtWin.x = 0;
		_txtWin.color = FlxColor.fromRGB(32, 168, 32, 255);
		add(_txtWin);
		
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
	}
	
	public function updateHUD(power:Float, powerless:Bool, win:Bool):Void {
		_imgBattery.scale.set(power, 1.0);
		
		if (power < 0.2) {
			_imgBattery.color = 0xffaa0000;
		} else if (power < 0.5) {
			_imgBattery.color = 0xffaa6633;
		} else {
			_imgBattery.color = 0xff00aa00;
		}
		
		if (powerless) {
			_txtBattery.text = "Out of battery... Press 'R' to restart !";
		}
		
		if (win) {
			_txtWin.text = "Thank you Robot !!";
		}
	}
}