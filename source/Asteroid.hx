package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;


class Asteroid extends FlxSprite
{
	public function new(?X:Float=0, ?Y:Float=0/*, ?Sprite*/)
	{
		super(X, Y);
	 	makeGraphic(110, 110, FlxColor.YELLOW);
	}

	override public function update(elapsed:Float):Void
	{
		velocity.set(PlayState.scrollSpeed, 0);
		velocity.rotate(FlxPoint.weak(0, 0), 180);

	 	super.update(elapsed);
	}
}
