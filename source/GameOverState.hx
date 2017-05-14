package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import openfl.Lib;

class GameOverState extends FlxState
{
    private var _gameOverText:FlxText;
    private var _scoreText:FlxText;
    private var _highscoreText:FlxText;

    private var _pressText:FlxText;
    private var _buttonText:FlxText;
    private var _restartText:FlxText;

    private var _press2Text:FlxText;
    private var _button2Text:FlxText;
    private var _quitText:FlxText;

    private var _scoreList:Array<FlxText> = [];
    private var _score:Int;


    public function new(Score:Int)
	{
		Global.scores.add(Score);
		_score = Score;
		Global.save.data.scores = Global.scores;
		Global.save.flush();

		super();
	}

	override public function create():Void
	{
		bgColor = FlxColor.BLACK;

		_gameOverText = new FlxText(0, 100, 1332, "Game Over!");
		_gameOverText.setFormat(null, 50, FlxColor.YELLOW, CENTER, OUTLINE);

		_scoreText = new FlxText(0, 200, 1332, "Score = " + _score);
		_scoreText.setFormat(null, 35, FlxColor.WHITE, CENTER, OUTLINE);

		createRestartText();
		createQuitText();
		createScoreList();

		add(_gameOverText);
		add(_scoreText);
		add(_highscoreText);

/*		FlxG.sound.playMusic(AssetPaths.Past_the_Edge__mp3);
*/
		super.create();
	}

	public function createRestartText():Void
	{
		_pressText = new FlxText(720, 220, 700, "Press");
		_pressText.setFormat(null, 30, FlxColor.WHITE, CENTER, OUTLINE);

		_buttonText = new FlxText(720, 260, 700, "R");
		_buttonText.setFormat(null, 45, FlxColor.RED, CENTER, OUTLINE);

		_restartText = new FlxText(720, 320, 700, "to restart");
		_restartText.setFormat(null, 25, FlxColor.WHITE, CENTER, OUTLINE);

		add(_pressText);
		add(_buttonText);
		add(_restartText);
	}

	public function createQuitText():Void
	{
		_press2Text = new FlxText(0, 220, 600, "Press");
		_press2Text.setFormat(null, 30, FlxColor.WHITE, CENTER, OUTLINE);

		_button2Text = new FlxText(0, 260, 600, "ESC");
		_button2Text.setFormat(null, 45, FlxColor.RED, CENTER, OUTLINE);

		_quitText = new FlxText(0, 320, 600, "to exit");
		_quitText.setFormat(null, 25, FlxColor.WHITE, CENTER, OUTLINE);

		add(_press2Text);
		add(_button2Text);
		add(_quitText);
	}

	public function createScoreList():Void
	{
		var scoreLineSpacing = 50;

		_highscoreText = new FlxText(0, 290, 1332, "Highscores");
		_highscoreText.setFormat(null, 35, FlxColor.WHITE, CENTER, OUTLINE);

		for (i in 0...Global.scores.size)
		{
			var tmp:FlxText;

			if (i == Global.scores.currentIdx)
			{
				tmp = new FlxText(0, 370 - 6 + scoreLineSpacing * i, 1332);
				tmp.setFormat(null, 30, FlxColor.YELLOW, CENTER, OUTLINE);
			}
			else
			{
				tmp = new FlxText(600, 370 + scoreLineSpacing * i, 1332);
				tmp.setFormat(null, 25, FlxColor.WHITE, LEFT, OUTLINE);
			}

			if (i == 0)
				tmp.text = "1st  : ";
			else if (i == 1)
				tmp.text = "2nd : ";
			else if (i == 2)
				tmp.text = "3rd : ";
			else
				tmp.text = Std.string(i + 1) + "th : ";

			if (Global.scores.get(i) == -1)
				tmp.text += "N/A";
			else
				tmp.text = tmp.text + Std.string(Global.scores.get(i));

			_scoreList.push(tmp);
			add(_scoreList[i]);
		}
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justReleased.R)
		{
			FlxG.switchState(new PlayState());
		}

		if (FlxG.keys.justReleased.ESCAPE)
		{
			Global.save.close();
			Lib.close();
		}

		super.update(elapsed);
	}
}
