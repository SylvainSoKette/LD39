package;

import Math;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author SoKette
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
	private var _txtPower:FlxText;
	
	public function new() 
	{
		super();
		
		_txtPower = new FlxText(0, 0, 0, "bap", 8);
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