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
	
	public function new() 
	{
		super();
		
		_bgHUD = new FlxSprite(0, 0, AssetPaths.HUD__png);
		add(_bgHUD);
		
		_imgBattery = new FlxSprite(221, 5);
		_imgBattery.makeGraphic(12, 5, FlxColor.WHITE);
		add(_imgBattery);
		
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
	}
	
	public function updateHUD(power:Float):Void {
		_imgBattery.scale.set(power, 1.0);
		
		if (power < 0.2) {
			_imgBattery.color = 0xffaa0000;
		} else if (power < 0.5) {
			_imgBattery.color = 0xffaa6633;
		} else {
			_imgBattery.color = 0xff00aa00;
		}
	}
}