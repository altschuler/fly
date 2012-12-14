package states.levelselect 
{
	import flash.display.MovieClip;
	import score.ScoreManager;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class LevelIcon extends MovieClip
	{
		public var lockIcon : MovieClip;
		public var awardIcon : MovieClip;
		public var thumbnail : MovieClip;
		
		private var _levelID : uint;
		private var _levelName : String;
		private var _locked : Boolean;
		
		public function LevelIcon(levelID : uint, levelName : String, locked : Boolean) 
		{
			_levelID = levelID;
			_levelName = levelName;
			_locked = locked;
			
			lockIcon.visible = locked;
			
			thumbnail.gotoAndStop(_levelID + 1);
		}
		
		public function update():void 
		{
			locked = _levelID == 0 ? false : ScoreManager.gi().getMaxAward(_levelID - 1) <= 1;
			
			awardIcon.gotoAndStop(1 + ScoreManager.gi().getMaxAward(_levelID));
		}
		
		public function get levelID():uint { return _levelID; }
		
		public function get levelName():String { return _levelName; }
		
		public function get locked():Boolean { return _locked; }
		
		public function set locked(value:Boolean):void 
		{
			_locked = lockIcon.visible = value;
		}
		
	}

}