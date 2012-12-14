package game.time 
{
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class TimeData
	{
		private var _time : uint;
		private var _level : uint;
		private var _player : String;
		
		public function TimeData(time : uint = 0, _level :uint = 0, player : String = "") 
		{
			_time = time;
			_level = level;
			_player = player;
		}
		
		public function get time():uint { return _time; }
		
		public function set time(value:uint):void 
		{
			_time = value;
		}
		
		public function get level():uint { return _level; }
		
		public function set level(value:uint):void 
		{
			_level = value;
		}
		
		public function get player():String { return _player; }
		
		public function set player(value:String):void 
		{
			_player = value;
		}
		
	}

}