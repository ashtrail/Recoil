package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import Global.Obstacle as Obstacle;

/*@:enum
abstract HttpStatus(Int)
{
  var NotFound = 404;
  var MethodNotAllowed = 405;
}
*/
// @:enum
// abstract Obstacle(Int)
// {
// 	var NONE = 0;
// 	var TOP = 1;
// 	var MIDDLE = 2;
// 	var BOTTOM = 3;
// 	var MOVING = 4;
// }

class PlayState extends FlxState
{
	public static var scrollSpeed = 350;

	public static var bullets:FlxTypedGroup<Bullet>;
	public static var asteroids:FlxTypedGroup<Asteroid>;
	public static var satellites:FlxTypedGroup<Satellite>;
	public static var score:Int = 0;
	public static var hud:HUD;

	private var _player:Player;

	private var _scoreTimer:FlxTimer;
	private var _speedTimer:FlxTimer;
	private var _generationTimer:FlxTimer;
	private var _lastObstacle = Obstacle.NONE;

	override public function create():Void
	{
		bgColor = FlxColor.BLUE;

		score = 0;
		// Changing cursor
		var sprite = new FlxSprite();
		sprite.loadGraphic(AssetPaths.cursor__png, false, 15, 15);
		FlxG.mouse.load(sprite.pixels);

		// Creating HUD
		hud = new HUD();

		// Creating Player
		_player = new Player(100, 320);

		// Generating bullet pool
		var bulletPoolSize:Int = 15;
		var bullet:Bullet;

		bullets = new FlxTypedGroup<Bullet>(bulletPoolSize);
		for(i in 0...bulletPoolSize)
		{
			bullet = new Bullet();
			bullet.exists = false;
			bullets.add(bullet);
		}

		// Generating asteroid pool
		var asteroidPoolSize:Int = 6;
		var asteroid:Asteroid;

		asteroids = new FlxTypedGroup<Asteroid>(asteroidPoolSize);
		for(i in 0...asteroidPoolSize)
		{
			asteroid = new Asteroid();
			asteroid.exists = false;
			asteroids.add(asteroid);
		}

		// Generating satellite pool
		var satellitePoolSize:Int = 6;
		var satellite:Satellite;

		satellites = new FlxTypedGroup<Satellite>(satellitePoolSize);
		for(i in 0...satellitePoolSize)
		{
			satellite = new Satellite();
			satellite.exists = false;
			satellites.add(satellite);
		}


		// the order in which you add the different objects has an impact
		// on the order in which they are displayed on the screen

//		add(background);
		add(asteroids);
		add(satellites);
		add(bullets);
		add(_player);
		add(hud);

		_scoreTimer = new FlxTimer();
		_scoreTimer.start(0.1, increaseScore, 0);

		_speedTimer = new FlxTimer();
		_speedTimer.start(5, increaseSpeed, 7);

		_generationTimer = new FlxTimer();
		_generationTimer.start(2.5, generateObstacle, 0);

/*		FlxG.sound.playMusic(AssetPaths.Black_Vortex__mp3);
*/
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		hud.updateHUD(_player.shotAngle);

		for (bullet in bullets)
		{
			if (bullet.exists && !bullet.isOnScreen())
				bullet.kill();
			else if (bullet.exists)
				bullet.draw();
		}

		for (asteroid in asteroids)
		{
			if (asteroid.exists && !asteroid.isOnScreen())
				asteroid.kill();
			else if (asteroid.exists)
				asteroid.draw();
		}


		for (satellite in satellites)
		{
			if (satellite.exists && !satellite.isOnScreen())
				satellite.kill();
			else if (satellite.exists)
				satellite.draw();
		}


		// collisions
		FlxG.overlap(bullets, asteroids, bulletAsteroidCollision);
		FlxG.overlap(bullets, satellites, bulletSatelliteCollision);
		FlxG.overlap(_player, asteroids, playerAsteroidCollision);
		FlxG.overlap(_player, satellites, playerSatelliteCollision);

		super.update(elapsed);
	}

	override public function destroy():Void
	{
		super.destroy();

		_player = null;
		bullets = null;
		asteroids = null;
		satellites = null;
	}

	public function increaseScore(Timer:FlxTimer):Void
	{
		score += 10;
	}

	public function increaseSpeed(Timer:FlxTimer):Void
	{
		scrollSpeed += 50;
		_generationTimer.reset(_generationTimer.time - 0.5);
	}

	public function generateObstacle(Timer:FlxTimer):Void
	{
		var type:Int;
		var probPool = new ProbabilityPool();

		if (_lastObstacle == Obstacle.NONE)
		{
			type = FlxG.random.int(1, 4);
		}
		else if (_lastObstacle == Obstacle.MOVING)
		{
			probPool.add(Obstacle.TOP, 25);
			probPool.add(Obstacle.MIDDLE, 25);
			probPool.add(Obstacle.BOTTOM, 25);
			probPool.add(Obstacle.MOVING, 25);
			type = probPool.resolve();
		}
		else
		{
			for (i in Obstacle.TOP...Obstacle.MOVING)
			{
				var percent = ((i == _lastObstacle) ? 15.0 : 25.0);
				probPool.add(i, percent);
			}
			probPool.add(Obstacle.MOVING, 35);
			type = probPool.resolve();
		}

		switch (type)
		{
			case (Obstacle.TOP):
				var asteroid = asteroids.recycle();
				asteroid.reset(1230, 120);
			case (Obstacle.MIDDLE):
				var asteroid = asteroids.recycle();
				asteroid.reset(1230, 305);
			case (Obstacle.BOTTOM):
				var asteroid = asteroids.recycle();
				asteroid.reset(1230, 470);
			case (Obstacle.MOVING):
				var satellite = satellites.recycle();
				satellite.reset(1230, 305);
		}
		_lastObstacle = type;
	}

	public function bulletAsteroidCollision(Bullet:FlxObject, Asteroid:FlxObject):Void
	{
		Bullet.kill();
	}

	public function bulletSatelliteCollision(Bullet:FlxObject, Satellite:FlxObject):Void
	{
		Bullet.kill();
		Satellite.hurt(1);
		FlxG.sound.play(AssetPaths.hurt__wav);
	}

	public function playerAsteroidCollision(Player:FlxObject, Asteroid:FlxObject):Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, gameOver);
	}

	public function playerSatelliteCollision(Player:FlxObject, Satellite:FlxObject):Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, gameOver);
	}

	static public function playerBorderCollision():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .33, false, gameOver);
	}

	static public function gameOver():Void
	{
		FlxG.sound.play(AssetPaths.death__wav);
		FlxG.switchState(new GameOverState(score));
	}

}
