package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class TimeEvent extends Event
	{
		public static const TIME_UPDATE : String = "TIME_UPDATE";
		
		private var _time : uint;
		
		public function TimeEvent(type:String, time : uint, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			_time = time;
		}
		
		public function get time():uint { return _time; }
	}

}