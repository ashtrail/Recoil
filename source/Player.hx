package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.util.FlxTimer;
import Math;

class Player extends FlxSprite
{
	public var 	speed:Float = 350;

	public var 	shotAngle:Float = 0;
	public var 	reloading = false;
	// private var _reloadTimer:FlxTimer;
	private var _shotTimer:FlxTimer;


	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
	 	makeGraphic(60, 80, FlxColor.WHITE);
	 	drag.x = drag.y = 400;
	 	// _reloadTimer = new FlxTimer();
	 	_shotTimer = new FlxTimer();
	}

	override public function update(elapsed:Float):Void
	{
		shooting();

		if (x < 50 || x > 1380 || y < 50 || y > 600)
			PlayState.playerBorderCollision();

		super.update(elapsed);
	}

	private function oppositeAngle(angle:Float):Float
	{
		// converting angle back to real degrees
		if (angle < 0)
			angle += 360;

		// finding 'opposite' angle for recoil
		angle = (angle + 180) % 360;
		return (FlxAngle.wrapAngle(angle));
	}

	public function shooting():Void
	{
		if (FlxG.mouse.justReleased && !reloading)
		{
			var pos = getGraphicMidpoint();
			var mousePos = FlxG.mouse.getScreenPosition();

			// finding angle between the player and the mouse
			var rad = Math.atan2(mousePos.y - pos.y, mousePos.x - pos.x);
			shotAngle = FlxAngle.wrapAngle((rad/Math.PI) * 180);

			// we shoot following the shotAngle direction
			var bullet = PlayState.bullets.recycle();
			bullet.respawn(pos.x, pos.y, shotAngle);

			// applying recoil to player
			velocity.set(speed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), oppositeAngle(shotAngle));

			reloading = true;

			FlxG.sound.play(AssetPaths.shot__wav);
			// wait until the end of the sound
			_shotTimer.start(0.3, finishReload, 1);
		}
	}

	// private function reload(Timer:FlxTimer):Void
	// {
	// 	FlxG.sound.play(AssetPaths.reload__wav);
	// 	_reloadTimer.start(0.2, finishReload, 1);
	// }

	private function finishReload(Timer:FlxTimer):Void
	{
		reloading = false;
	}
}
