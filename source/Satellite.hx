package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;

class Satellite extends FlxSprite
{
	public var 	verticalScroll:Float = 250;
	private var _hp:Int = 2;

	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
	 	makeGraphic(110, 110, FlxColor.GREEN);
	 	if (FlxG.random.int(1, 2) == 1)
	 		verticalScroll = -verticalScroll;
	}

	override public function update(elapsed:Float):Void
	{
		if (y < 150 || y > 440)
			verticalScroll = -verticalScroll;

		velocity.set(-PlayState.scrollSpeed, verticalScroll);

	 	super.update(elapsed);
	}

	override public function hurt(Damage:Float):Void
	{
		_hp -= cast (Damage, Int);
	 	makeGraphic(110, 110, FlxColor.PURPLE);
		if (_hp == 0)
		{
			PlayState.score += 1000;
			PlayState.hud.popupText("+1000!");
			kill();
		}
		FlxG.sound.play(AssetPaths.explosion__wav);
	}
}
