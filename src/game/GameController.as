package game 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2Joint;
	import com.actionsnippet.qbox.QuickBox2D;
	import events.LevelEvent;
	import events.TimeEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import game.hero.Hero;
	import game.time.TimeData;
	import game.time.TimeManager;
	import level.LevelContoller;
	import utils.GlobalStage;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class GameController extends EventDispatcher
	{
		static private var _currentLevelIndex : uint;
		private var _gameContainer : MovieClip;
		private var _world : QuickBox2D;
		private var _levelController : LevelContoller;
		private var _timeManager : TimeManager;
		
		public function GameController(gameContainer : MovieClip) 
		{	
			_gameContainer = gameContainer;
			_currentLevelIndex = 0;
			
			setupTimeManager();
			setupLevelController();
		}
		
		public function restartCurrentLevel():void
		{
			_world.stop();
			_timeManager.endTime();
			
			buildLevel(_currentLevelIndex);
		}
		
		public function playNextLevel():void
		{
			_currentLevelIndex++;
			
			buildLevel(_currentLevelIndex);
		}
		
		private function setupTimeManager():void
		{
			_timeManager = new TimeManager();
			_timeManager.addEventListener(TimeEvent.TIME_UPDATE, timeUpdated);
		}
		
		private function timeUpdated(e:TimeEvent):void 
		{
			var ev:TimeEvent = new TimeEvent(e.type, e.time);
			dispatchEvent(ev);
		}
		
		private function setupLevelController():void
		{
			_levelController = new LevelContoller();
			_levelController.addEventListener(LevelEvent.LEVEL_FINISHED, levelFinished);
			_levelController.addEventListener(LevelEvent.LEVEL_FAILED, levelFailed);
		}
		
		private function levelFailed(e:LevelEvent):void 
		{
			var levelTime : uint = _timeManager.endTime();
			
			_world.stop();
			
			dispatchEvent(new LevelEvent(LevelEvent.LEVEL_FAILED, e.levelID, levelTime));
		}
		
		private function levelFinished(e:LevelEvent):void 
		{
			var levelTime : uint = _timeManager.endTime();
			
			_world.stop();
			
			dispatchEvent(new LevelEvent(LevelEvent.LEVEL_FINISHED, e.levelID, levelTime));
		}
		
		private function setupWorld():void 
		{
			if (_world)
				clearWorld();
			
			_world = new QuickBox2D(_gameContainer);
			_world.setDefault( { lineAlpha:1, fillAlpha:.4 } );
			_world.traceMouse();
			_world.mouseDrag();
			//_world.frim = false;
			//GlobalStage.reference.frameRate = 2;
		}
		
		private function clearWorld():void
		{
			var b : b2Body = _world.w.GetBodyList();
			while (b.m_next)
			{
				if (b.GetUserData() is Sprite && b.GetUserData().parent)
				{
					if (b.GetUserData().parent.contains(b.GetUserData())) b.GetUserData().parent.removeChild(b.GetUserData());
				}
				b = b.m_next;
			}
			//TODO remove joints
			/*var j : b2Joint = _world.w.GetJointList();
			if (j)
			{
				do 
				{
					if (j.GetUserData() is Sprite) 
					{
						j.GetUserData().parent.removeChild(j.GetUserData());
					}
					j = j.m_next;
				} while (j.m_next)
			}*/
			_world.destroy();
		}
		
		public function buildCurrentLevel():void
		{
			buildLevel(_currentLevelIndex);
		}
		
		private function buildLevel(index:uint):void
		{
			setupWorld();
			_levelController.buildLevel(index, _world);
			
			dispatchEvent(new LevelEvent(LevelEvent.LEVEL_BUILD, _levelController.currentLevel.ID));
		}
		
		public function startLevel():void
		{
			_world.start();
			_levelController.runCurrentLevel();
			_timeManager.startTime();	
			
			dispatchEvent(new LevelEvent(LevelEvent.LEVEL_START, _levelController.currentLevel.ID));
		}
		
		public function togglePauseGame():Boolean
		{
			if (_world.isRunning()) 
			{
				_world.stop();
				_timeManager.pauseTime();
			}
			else 
			{
				_world.start();
				_timeManager.resumeTime();
			}
			
			return _world.isRunning();
		}
		
		public function stopGame():void 
		{
			_world.stop();
			clearWorld();
		}
		
		static public function get currentLevelIndex():uint { return _currentLevelIndex; }
		
		static public function set currentLevelIndex(value:uint):void 
		{
			_currentLevelIndex = value;
		}
		
	}

}