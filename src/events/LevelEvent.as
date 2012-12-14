package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class LevelEvent extends Event
	{
		public static const LEVEL_FINISHED : String = "LEVEL_FINISHED";
		public static const LEVEL_FAILED : String = "LEVEL_FAILED";
		public static const LEVEL_BUILD : String = "LEVEL_BUILD";
		public static const LEVEL_START : String = "LEVEL_START";
		public static const LEVEL_COUNTDOWN_START : String = "LEVEL_COUNTDOWN_START";
		
		private var _levelID : uint;
		private var _time : uint;
		
		public function LevelEvent(type:String, levelID:uint, time : uint = 0, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			_levelID = levelID;
			_time = time;
		}
		
		public function get levelID():uint { return _levelID; }
		
		public function get time():uint { return _time; }
		
	}

}