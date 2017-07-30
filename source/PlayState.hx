package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.system.FlxSound;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxCamera.FlxCameraFollowStyle;

class PlayState extends FlxState
{
	//private var _background:FlxSprite;
	private var _background:FlxTypedGroup<FlxSprite>;
	private var _terrainmap:FlxTilemap;
	private var _objectmap:FlxTilemap;
	private var _lightmap:FlxTilemap;
	private var _lightlayer:FlxTypedGroup<FlxSprite>;
	
	private var _player:Player;
	private var _timmy:Timmy;
	private var _hud:HUD;
	
	override public function create():Void {
		FlxG.mouse.visible = false;
		FlxG.sound.volume = 0.5;
		
		//background
		//bgColor = 0xff1e1e1e;
		//_background = new FlxSprite();
		// why in hell can't I load a png on windows/neko build ??? too big ?
		// I never had this limitation before, strange !
		//_background.loadGraphic("assets/images/background1.png", false, 512, 512);
		//_background.loadGraphic("assets/images/bg_10.png", false, 256, 256);
		//add(_background);
		_background = new FlxTypedGroup<FlxSprite>();
		initBackground();
		
		// map
		_terrainmap = new FlxTilemap();
		_objectmap = new FlxTilemap();
		_lightmap = new FlxTilemap();
		_lightlayer = new FlxTypedGroup<FlxSprite>();
		initMap();
		
		// timmy
		
		// player
		
		
		// HUD
		_hud = new HUD();
		
		// sprite layers
		add(_background);
		add(_terrainmap);
		add(_objectmap);
		
		add(_timmy);
		add(_player);
		
		add(_lightlayer);
		add(_hud);
		
		super.create();
	}

	override public function update(elapsed:Float):Void {
		FlxG.collide(_terrainmap, _player);
		FlxG.collide(_terrainmap, _timmy);
		
		controls();
		
		if (_timmy.isGrabbed()) {
			_timmy.moveTimmy(_player.x, (_player.y - (Blackboard.TILE_HEIGHT / 2)));
		}
		
		if (_player.overlaps(_lightlayer)) {
			_player.drainPower( -0.0012);
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
		if (FlxG.keys.pressed.SHIFT)
			_player.turbo();
		if (FlxG.keys.justPressed.SPACE && _player.isTouching(FlxObject.FLOOR))
			_player.turboJump();
		if (FlxG.keys.justPressed.CONTROL)
			_player.blink();
	}
	
	private function initMap():Void {
		initTerrain();
		initObjects();
		initLights();
	}
	
	private function initTerrain():Void {
		_terrainmap.loadMapFromCSV(AssetPaths.map_terrain__csv, AssetPaths.tileset__png, Blackboard.TILE_WIDTH, Blackboard.TILE_HEIGHT);
		FlxG.worldBounds.left = 0;
		FlxG.worldBounds.right = Blackboard.MAP_WIDTH * Blackboard.TILE_WIDTH;
		FlxG.worldBounds.top = 0;
		FlxG.worldBounds.bottom = Blackboard.MAP_HEIGHT * Blackboard.TILE_HEIGHT;
		#if debug
			trace("Terrain loaded !");
		#end
	}
	
	private function initObjects():Void {
		_objectmap.loadMapFromCSV(AssetPaths.map_obj__csv, AssetPaths.decals__png, Blackboard.TILE_WIDTH, Blackboard.TILE_HEIGHT);
		for (ty in 0 ... _objectmap.heightInTiles) {
			for (tx in 0 ... _objectmap.widthInTiles) {
				var tileValue:Int = _objectmap.getTile(tx, ty);
				switch (tileValue) {
					case 3: // player
						_objectmap.setTile(tx, ty, -1);
						_player = new Player(tx * Blackboard.TILE_WIDTH, ty * Blackboard.TILE_HEIGHT);
						camera.follow(_player, FlxCameraFollowStyle.PLATFORMER);
						camera.setScrollBoundsRect(0, 0, _objectmap.widthInTiles * Blackboard.TILE_WIDTH , _objectmap.heightInTiles * Blackboard.TILE_HEIGHT);
					case 4: // timmy
						_objectmap.setTile(tx, ty, -1);
						_timmy = new Timmy(tx * Blackboard.TILE_WIDTH, ty * Blackboard.TILE_HEIGHT);
					default :
						trace("Nothing special to load on tile X:"+ tx +" Y:"+ ty);
				}
			}
		}
		#if debug
			trace("Objects loaded !");
		#end
	}
	
	private function initLights():Void {
		_lightmap.loadMapFromCSV(AssetPaths.map_light__csv, AssetPaths.decals__png, Blackboard.TILE_WIDTH, Blackboard.TILE_HEIGHT);
		for (ty in 0 ... _lightmap.heightInTiles) {
			for (tx in 0 ... _lightmap.widthInTiles) {
				var tileValue:Int = _lightmap.getTile(tx, ty);
				switch (tileValue) {
					case 1: // sunlight
						_lightmap.setTile(tx, ty, -1);
						_lightlayer.add(new Sunlight(tx * Blackboard.TILE_WIDTH, ty * Blackboard.TILE_HEIGHT));
					case 2: // nuclear glow
						_lightmap.setTile(tx, ty, -1);
						_lightlayer.add(new Nuclearlight(tx * Blackboard.TILE_WIDTH, ty * Blackboard.TILE_HEIGHT));
					default : // everything else is for decoration
						trace("Nothing special to load on tile X:"+ tx +" Y:"+ ty);
				}
			}
		}
		#if debug
			trace("Lights loaded !");
		#end
	}
	
	private function initBackground():Void {
		var x_div:Int = 1;
		var y_div:Int = 40;
		
		var size_x:Int = Math.round((Blackboard.TILE_WIDTH * Blackboard.MAP_WIDTH) / x_div);
		var size_y:Int = Math.round((Blackboard.TILE_HEIGHT * Blackboard.MAP_HEIGHT) / y_div);
		
		for (bx in 0 ... x_div) {
			trace("bx : " + bx);
			for (by in 0 ... y_div) {
				trace("by : " + by);
				_background.add((
					new FlxSprite(bx * size_x, by * size_y)
						).makeGraphic(size_x, size_y, FlxColor.fromRGB(
							Math.round(255 / (Math.pow(2, by))),
							Math.round(10 + 255 / (Math.pow(2, by))),
							Math.round(20 + 255 / (Math.pow(2, by))),
							255
						)
					)
				);
			}
		}
	}
}