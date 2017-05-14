package;

class ScoreList
{
	public var currentIdx:Int;
	public var size:Int;
	private var _list:Array<Int> = [];

	public function new(Size:Int)
	{
		size = Size;
		currentIdx = -1;

		for (i in 0...size)
			_list.push(-1);
	}

	// adds a score to the score _list and returns it's rank : first, third, ... or even nothing
	public function add(NewScore:Int):Int
	{
		var i:Int = 0;

		while (i < size && NewScore < _list[i])
			++i;

		if (i == size)
			currentIdx = -1;
		else
		{
			currentIdx = i;
			_list.insert(i, NewScore);
			_list.pop();
		}
		return (currentIdx + 1);
	}

	public function get(Idx:Int):Int
	{
		return (_list[Idx]);
	}
}