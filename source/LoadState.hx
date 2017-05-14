package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxSave;


class LoadState extends FlxState
{
	override public function create():Void
	{
		Global.save.bind("SVTSave");
		if (Global.save.data.scores != null)
			Global.scores = Global.save.data.scores;
		FlxG.switchState(new PlayState());
		super.create();
	}
}
