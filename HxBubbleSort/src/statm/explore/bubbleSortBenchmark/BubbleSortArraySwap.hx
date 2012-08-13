package statm.explore.bubbleSortBenchmark;

/**
 * ...
 * @author statm
 */

class BubbleSortArraySwap
{

	static public function sort(array:Array<Int>):Void
	{
		var temp:Int;
		var l:Int = array.length;
		
		while (l > 0)
		{
			for (i in 0...l)
			{
				if (array[i] > array[i + 1])
				{
					temp = array[i];
					array[i] = array[i + 1];
					array[i + 1] = temp;
				}
			}
			
			l--;
		}
	}
	
}