package;

import flixel.text.FlxText;

/**
 * ...
 * @author SoKette
 */
class SkText extends FlxText 
{

	public function new(?text:String, size:Int=8, center:Bool=true) {
		super(text, size);
		
		new FlxText();
		this.text = text;
		this.size = size;
		this.color = 0xff69beef;
		this.borderStyle = SHADOW;
		this.borderColor = 0xff222222;
		this.borderSize = size / 4;
		this.shadowOffset.x = 0.75;
		this.shadowOffset.y = 0.75;
		
		if (center)
		{
			this.screenCenter();
		}
	}
}