package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;

/**
 * ...
 * @author SoKette
 */
class ExplainState extends FlxState
{
	private var _background:FlxSprite;
	
	override public function create():Void {
		FlxG.mouse.visible = false;
		_background = new FlxSprite(0, 0, AssetPaths.explain__png);
		add(_background);
		
		super.create();
	}

	override public function update(elapsed:Float):Void {
		
		if (FlxG.keys.justPressed.SPACE)
			FlxG.switchState(new PlayState());
		if (FlxG.keys.justPressed.ESCAPE)
			FlxG.switchState(new MenuState());
		
		super.update(elapsed);
	}
}