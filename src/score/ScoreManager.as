package score 
{
	import flash.net.SharedObject;
	import level.LevelContoller;
	import utils.ArrayUtils;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class ScoreManager
	{
		static private var _instance : ScoreManager;
		static public function gi():ScoreManager
		{
			return _instance ? _instance : _instance = new ScoreManager();
		}
		
		private var _scores : Object;
		private var _awardTable : Array;
		
		public function ScoreManager() 
		{
			_awardTable = new Array();
			_awardTable[0] = [14000, 20000, 25000];
			_awardTable[1] = [6000, 8000, 10000];
			_awardTable[2] = [3000, 4000, 5000];
			_awardTable[3] = [3000, 4000, 5000];
			_awardTable[4] = [3000, 4000, 5000];
			_awardTable[5] = [3000, 4000, 5000];
			_awardTable[6] = [3000, 4000, 5000];
			_awardTable[7] = [3000, 4000, 5000];
			_awardTable[8] = [3000, 4000, 5000];
			_awardTable[9] = [3000, 4000, 5000];
			_awardTable[10] = [3000, 4000, 5000];
			_awardTable[11] = [3000, 4000, 5000];
			_awardTable[12] = [3000, 4000, 5000];
			_awardTable[13] = [3000, 4000, 5000];
		}
		
		public function getBestTime(levelID : uint):int 
		{
			var a : Array = _scores[levelID] as Array;
			var best : uint = ArrayUtils.min(a, "time");
			if (best > 0) return best; 
			else return -1;
		}
		
		public function getAwardTimes(levelID : uint):Array
		{
			return _awardTable[levelID];
		}
		
		public function addScore(s:Score, flush : Boolean = true):void
		{
			var levelScores : Array = _scores[s.levelID] as Array;
			levelScores.push(s);
			
			if (flush) flushScores();
		}
		
		public function getSortedScores(levelID:uint):Array
		{
			var a : Array = _scores[levelID] as Array;
			a = a.sortOn("time");
			return a;
		}
		
		public function getMaxAward(levelID:uint):uint
		{
			var a : Array = _scores[levelID] as Array;
			if (a && a.length > 0)
			{
				return ArrayUtils.max(a, "award");
			}
			return 0;
		}
		
		public function loadScores():void
		{
			/*var so : SharedObject = SharedObject.getLocal("Scores");
			if (so.data.scores) 
			{
				_scores = so.data.scores
			}
			else
			{*/
				_scores = new Object();
				for (var i:int = 0; i < LevelContoller.getLevels().length; i++) 
				{
					_scores[i] = new Array();
				}
			//}
		}
		
		public function flushScores():void
		{
			var so : SharedObject = SharedObject.getLocal("Scores");
			so.data.scores = _scores;
		}
		
		public function serialize():Object
		{
			var o : Object = { };
			
			return o;
		}
		
		public function getAward(levelID:uint, time:uint):uint 
		{
			if (time <= _awardTable[levelID][0]) return 3;
			if (time <= _awardTable[levelID][1]) return 2;
			if (time <= _awardTable[levelID][2]) return 1;
			return 0;
		}
	}

}