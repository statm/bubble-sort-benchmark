package statm.explore.bubbleSortBenchmark;
import flash.Memory;
import flash.utils.ByteArray;

/**
 * ...
 * @author statm
 */

class BubbleSortMemSwap
{

	static public function sort(array:Array<Int>):Void
	{
		var length:Int = array.length;
		var byteLength:Int = length * 4;
		if (byteLength < 0x3FF) // 1023
		{
			byteLength = 0x400; // 1024
		}
		
		var ba:ByteArray = new ByteArray();
		ba.length = byteLength;
		
		Memory.select(ba);
		
		var l:Int = length;	
		
		for (i in 0...l)
		{
			Memory.setI32(4 * i, array[i]);
		}
		
		var j:Int = length;
		
		while (--j > -1)
		{
			for (i in 0...j)
			{
				var left:Int = Memory.getI32(i * 4);
				var right:Int = Memory.getI32(i * 4 + 4);
				
				if (left > right)
				{
					Memory.setI32(i * 4, right);
					Memory.setI32(i * 4 + 4, left);
				}
			}
		}
		
		for (i in 0...l)
		{
			array[i] = Memory.getI32(i * 4);
		}
	}
}