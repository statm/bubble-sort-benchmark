package
{
	import cmodule.sort.CLibInit;
	import statm.explore.bubbleSortBenchmark.*;
	
	/**
	 * AS、Alchemy、HaXe 的性能测试。
	 * 测试内容：用冒泡法对逆序数组进行排序。
	 * 
	 * @author statm
	 */
	public class SortBenchmarking extends PerfTestBase
	{
		private static const LENGTH : int = 5000;
		
		public function SortBenchmarking()
		{
			super();
			setup();
			
			queueTest( 	{ f: ASArraySwap, n: "纯AS(数组交换)" },
						{ f: AlchemyArraySwap, n: "Alchemy(数组交换)" },
						{ f: HaXeArraySwap, n: "HaXe(数组交换)" },
						{ f: HaXeMemCopy, n: "HaXe(内存复制)" },
						{ f: HaXeMemSwap, n: "HaXe(内存交换)"});
		}
		
		private var arr1 : Array, arr2 : Array, arr3 : Array, arr4 : Array, arr5 : Array;
		
		private function setup() : void
		{
			arr1 = [];
			
			for (var i : int = 0; i < LENGTH; i++)
			{
				arr1[i] = LENGTH - i;
			}
			
			arr2 = arr1.concat();
			arr3 = arr1.concat();
			arr4 = arr1.concat();
			arr5 = arr1.concat();
		}
		
		private function ASArraySwap() : void
		{
			var temp : int;
			var l : int = LENGTH;
			
			while (l > 0)
			{
				for (var i : int = 0; i < l; i++)
				{
					if (arr1[i] > arr1[i + 1])
					{
						temp = arr1[i];
						arr1[i] = arr1[i + 1];
						arr1[i + 1] = temp;
					}
				}
				
				l--;
			}
		}
		
		private function AlchemyArraySwap() : void
		{
			var test : CLibInit = new CLibInit();
			var sortObj : Object = test.init();
			arr2 = sortObj.sort(arr2);
		}
		
		private function HaXeArraySwap() : void
		{
			BubbleSortArraySwap.sort(arr3);
		}
		
		private function HaXeMemCopy() : void
		{
			BubbleSortMemCopy.sort(arr4);
		}
		
		private function HaXeMemSwap() : void
		{
			BubbleSortMemSwap.sort(arr5);
		}
	}

}