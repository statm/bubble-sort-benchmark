package 
{
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	public class PerfTestBase extends Sprite
	{
		public const WAIT_TIME:uint = 200;
		
		public function PerfTestBase()
		{
			setTimeout(startTest, WAIT_TIME);
		}
		
		protected function startTest():void
		{
			next();
		}
		
		private var testQueue:Array = [];
		
		protected function queueTest(... rest):void
		{
			for each (var o:Object in rest)
			{
				testQueue[testQueue.length] = o;
			}
		}
		
		private var testIndex:int = 0;
		
		protected function next():void
		{
			if (testQueue.length == 0)
			{
				return;
			}
			
			var o:Object = testQueue.shift();
			var func:Function = o.f as Function;
			var name:String = o.n as String;
			
			setTimeout(function():void
				{
					var t:int = getTimer();
					func();
					trace(name + ":\t" + (getTimer() - t) + "ms");
					next();
				}, WAIT_TIME);
		}
	}
}