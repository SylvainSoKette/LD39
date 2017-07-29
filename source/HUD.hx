package;

import Math;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

import SkText;

/**
 * ...
 * @author SoKette
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
	private var _txtPower:SkText;
	
	public function new() 
	{
		super();
		
		_txtPower = new SkText("bap", 8, false);
		add(_txtPower);
		
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
	}
	
	public function updateHUD(power:Float):Void {
		_txtPower.text = "Battery " + Math.round(power*100) + "%";
	}
}