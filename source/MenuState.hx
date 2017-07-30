package;

import lime.system.System;
//import openfl.system.System;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	private var _background:FlxSprite;
	
	override public function create():Void {
		FlxG.mouse.visible = false;
		_background = new FlxSprite(0, 0, AssetPaths.splashscreen__png);
		add(_background);
		
		super.create();
	}

	override public function update(elapsed:Float):Void {
		
		if (FlxG.keys.justPressed.SPACE)
			FlxG.switchState(new PlayState());
		if (FlxG.keys.justPressed.ESCAPE)
			System.exit(0); // lime
			//System.exit(); // openfl
		
		super.update(elapsed);
	}
}