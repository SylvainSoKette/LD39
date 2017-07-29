package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	private static var WIDTH:Int = 240;		// 480 | 240
	private static var HEIGHT:Int = 135; 	// 270 | 135
	private static var ZOOM:Int = 1;
	private static var RATE:Int = 60;
	private static var SKIP_SPLASH:Bool = true;
	private static var FULLSCREEN:Bool = false;
	
	public function new()
	{
		super();
		addChild(new FlxGame(WIDTH, HEIGHT, MenuState, ZOOM, RATE, RATE, SKIP_SPLASH, FULLSCREEN));
	}
}