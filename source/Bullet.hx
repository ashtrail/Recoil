package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;


class Bullet extends FlxSprite
{
	public var bulletSpeed:Float = 500;

	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
	 	makeGraphic(24, 12, FlxColor.RED);
	}

	override public function update(elapsed:Float):Void
	{
		velocity.set(bulletSpeed, 0);
	 	velocity.rotate(FlxPoint.weak(0, 0), angle);

	 	super.update(elapsed);
	}

	public function respawn(X:Float, Y:Float, Angle:Float):Void
	{
		super.reset(X, Y);
		angle = Angle;
	}

}
