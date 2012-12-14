package score 
{
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Score
	{
		private var _levelID : uint;
		private var _time : uint;
		private var _playerName :String;
		
		//0=nothing, 1 = bronze, 2 = silver, 3 = gold
		private var _award : uint;
		
		public function Score(levelID : uint, time : uint, playerName : String) 
		{
			_levelID = levelID;
			_time = time;
			_playerName = playerName;
			
			_award = ScoreManager.gi().getAward(levelID, time);
		}
		
		public function get levelID():uint { return _levelID; }
		
		public function get time():uint { return _time; }
		
		public function get playerName():String { return _playerName; }
		
		public function get award():uint { return _award; }
		
	}

}