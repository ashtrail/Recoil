package;

import flixel.FlxG;

class ProbabilityPool
{
	public var currentSum:Float;
	private var _list:Array<Probability>;

	public function new()
	{
		_list = new Array<Probability>();
		currentSum = 0;
	}

	public function add(Idx:Int, Percent:Float):Bool
	{
		if (currentSum + Percent > 100)
			return (false);
		currentSum += Percent;
		var addon = new Probability(Idx, Percent, currentSum);
		_list.push(addon);
		return (true);
	}

	public function fill(Idx:Int):Bool
	{
		if (currentSum == 100)
			return (false);
		var addon = new Probability(Idx, 100 - currentSum, 100);
		currentSum = 100;
		_list.push(addon);
		return (true);
	}

	public function resolve():Int
	{
		var roll = FlxG.random.float(0, 100);
		var result = 0;

		for (i in 0..._list.length)
		{
			if (roll <= _list[i].realValue)
			{
				result = _list[i].idx;
				break;
			}
		}
		return (result);
	}
}