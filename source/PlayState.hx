package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.FlxCamera.FlxCameraFollowStyle;

class PlayState extends FlxState
{
	private var _terrainmap:FlxTilemap;
	private var _player:Player;
	private var _hud:HUD;
	private var _timmy:Timmy;
	
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		
		//background
		bgColor = 0xff1e1e1e;
		
		// map
		_terrainmap = new FlxTilemap();
		initMap();
		add(_terrainmap);
		
		// timmy
		_timmy = new Timmy(128, 8);
		add(_timmy);
		
		// player
		_player = new Player(32 , 8);
		add(_player);
		camera.follow(_player, FlxCameraFollowStyle.PLATFORMER);
		camera.setScrollBoundsRect(0, 0, 64 * Blackboard.TILE_WIDTH , 256 * Blackboard.TILE_HEIGHT);
		
		// HUD
		_hud = new HUD();
		add(_hud);
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(_terrainmap, _player);
		FlxG.collide(_terrainmap, _timmy);
		
		controls();
		
		if (_timmy.isGrabbed()) {
			_timmy.moveTimmy(_player.x, (_player.y - (Blackboard.TILE_HEIGHT / 2)));
		}
		
		_hud.updateHUD(_player.getPower());
		
		super.update(elapsed);
	}
	
	private function controls():Void {
		// menus
		if (FlxG.keys.justPressed.ESCAPE)
			FlxG.switchState(new MenuState());
		if (FlxG.keys.justPressed.R)
			FlxG.resetState();
		
		// player control
		_player.acceleration.x = 0;
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.S)
			_player.moveLeft();
		if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.F)
			_player.moveRight();
		if (FlxG.keys.pressed.UP || FlxG.keys.pressed.E)
			_player.hover();
		if (FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.D) {
			if (_timmy.isGrabbed()) {
				_timmy.drop();
			} else if (_player.overlaps(_timmy)) {
				_timmy.grab();
			}
		}
		if (FlxG.keys.pressed.SHIFT && _player.isTouching(FlxObject.FLOOR))
			_player.turbo();
		if (FlxG.keys.justPressed.SPACE && _player.isTouching(FlxObject.FLOOR))
			_player.turboJump();
		if (FlxG.keys.justPressed.CONTROL)
			_player.blink();
	}
	
	private function initMap():Void {
		_terrainmap.loadMapFromCSV(AssetPaths.map__csv, AssetPaths.tileset__png, Blackboard.TILE_WIDTH, Blackboard.TILE_HEIGHT);
		FlxG.worldBounds.left = 0;
		FlxG.worldBounds.right = Blackboard.MAP_WIDTH * Blackboard.TILE_WIDTH;
		FlxG.worldBounds.top = 0;
		FlxG.worldBounds.bottom = Blackboard.MAP_HEIGHT * Blackboard.TILE_HEIGHT;
	}
}