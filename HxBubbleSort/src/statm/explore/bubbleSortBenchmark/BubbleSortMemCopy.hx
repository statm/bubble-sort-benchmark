package statm.explore.bubbleSortBenchmark;
import flash.Lib;
import flash.Memory;
import flash.utils.ByteArray;

/**
 * ...
 * @author statm
 */

class BubbleSortMemCopy
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
		ba.length = byteLength * 2;
		
		Memory.select(ba);
		
		var l:Int = length;
		
		for (i in 0...l)
		{
			Memory.setI32(4 * i, array[i]);
		}
		
		for (j in 0...l)
		{
			var currentMin:Int = 0x7FFFFFFF; // Int.MAX
			var currentMinPos:Int = 0;
			
			for (i in 0...l)
			{
				var current:Int = Memory.getI32(i * 4);
				if (current < currentMin)
				{
					currentMin = current;
					currentMinPos = i;
				}
			}
			
			Memory.setI32(currentMinPos * 4, 0x7FFFFFFF); // Int.MAX
			Memory.setI32(byteLength + j * 4, currentMin);
		}
		
		for (i in 0...l)
		{
			array[i] = Memory.getI32(byteLength + i * 4);
		}
	}
	
}