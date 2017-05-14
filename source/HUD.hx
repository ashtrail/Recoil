package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{
    private var _topBanner:FlxSprite;
    private var _leftBanner:FlxSprite;
    private var _rightBanner:FlxSprite;
    private var _bottomBanner:FlxSprite;
    private var _scoreText:FlxText;
    private var _titleText:FlxText;
    private var _popupText:FlxText;
    private var _popupTimer:FlxTimer;

    public function new()
    {
        super();

        _topBanner = new FlxSprite(0, 0);
        _topBanner.makeGraphic(1332, 100, FlxColor.BLACK);

        _leftBanner = new FlxSprite(0, 0);
        _leftBanner.makeGraphic(50, 700, FlxColor.BLACK);

        _rightBanner = new FlxSprite(1282, 0);
        _rightBanner.makeGraphic(50, 700, FlxColor.BLACK);

        _bottomBanner = new FlxSprite(0, 600);
        _bottomBanner.makeGraphic(1332, 100, FlxColor.BLACK);

        _scoreText = new FlxText(550, 30, 500, "Score : 0");
        _scoreText.setFormat(null, 30, FlxColor.WHITE, LEFT, OUTLINE);

        _popupText = new FlxText(850, 30, 500, "+bonus!");
        _popupText.setFormat(null, 30, FlxColor.YELLOW, LEFT, OUTLINE);
        _popupText.alpha = 0;

        _popupTimer = new FlxTimer();

        _titleText = new FlxText(0, 630, 1332, "-- Space Volume Technician --");
        _titleText.setFormat(null, 30, FlxColor.WHITE, CENTER, OUTLINE);

        add(_topBanner);
        add(_leftBanner);
        add(_rightBanner);
        add(_bottomBanner);

        add(_scoreText);
        add(_titleText);
        add(_popupText);

        forEach(function(spr:FlxSprite)
        {
            spr.scrollFactor.set(0, 0);
        });
    }

    public function updateHUD(Angle:Float = 0):Void
    {
        _scoreText.text = "Score : " + PlayState.score;
    }

    public function popupText(Str:String):Void
    {
        if (!_popupTimer.finished)
            _popupTimer.cancel();
        _popupText.text = Str;
        _popupText.alpha = 1;
        _popupTimer.start(0.1, fadeOutPopup, 10);
    }

    public function fadeOutPopup(Timer:FlxTimer):Void
    {
        _popupText.alpha -= 0.1;
    }
}