package;

import flixel.util.FlxSave;

class Obstacle
{
	public static var NONE:Int 		= 0;
	public static var TOP:Int 		= 1;
	public static var MIDDLE:Int 	= 2;
	public static var BOTTOM:Int 	= 3;
	public static var MOVING:Int 	= 4;
}


class Global
{
	public static var Obstacle:Obstacle;

	public static var scores:ScoreList 	= new ScoreList(5);
	public static var save:FlxSave 		= new FlxSave();
}