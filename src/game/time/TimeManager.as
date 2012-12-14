package game.time 
{
	import events.TimeEvent;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class TimeManager extends EventDispatcher
	{
		private var _trigger : Timer;
		private var _start : uint;
		private var _pauseTime : uint;
		private var _times : Array;
		
		public function TimeManager() 
		{
			_trigger = new Timer(10);
			_trigger.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		public function startTime():void 
		{
			_start = getCurrentTime();
			_trigger.start();
		}
		
		private function getCurrentTime():uint
		{
			return new Date().getTime();
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			dispatchEvent(new TimeEvent(TimeEvent.TIME_UPDATE, getCurrentTime()-_start));
		}
		
		public function pauseTime():void 
		{
			_trigger.stop();
			_pauseTime = getCurrentTime();
		}
		
		public function resumeTime():void 
		{
			_trigger.start();
			_start += getCurrentTime() - _pauseTime;
		}
		
		public function endTime():uint 
		{
			var t : uint = getCurrentTime() - _start; 
			_trigger.stop();
			_start = 0;
			return t;
		}
		
		public function addTime(timeData : TimeData):void
		{
			_times.push(timeData);
		}
	}

}