package states.game 
{
	import com.greensock.TweenMax;
	import events.CountdownEvent;
	import events.LevelEvent;
	import events.MenuButtonEvent;
	import events.TimeEvent;
	import flash.display.MovieClip;
	import game.animation.AnimationManager;
	import game.GameController;
	import game.gui.Countdown;
	import game.gui.InfoBar;
	import game.gui.InGameMenu;
	import game.gui.LevelFailedMenu;
	import game.gui.LevelFinishedMenu;
	import level.LevelContoller;
	import score.Score;
	import score.ScoreManager;
	import states.State;
	import utils.ArrayUtils;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class GameState extends State
	{
		public static const PRE_COUNTDOWN : String = "PRE_COUNTDOWN";
		public static const COUNTDOWN : String = "COUNTDOWN";
		public static const PLAYING : String = "PLAYING";
		public static const PAUSED_PLAYING : String = "PAUSED_PLAYING";
		public static const PAUSED_COUNTDOWN : String = "PAUSED_COUNTDOWN";
		public static const LEVEL_END : String = "LEVEL_END";
		public static const BUILDING : String = "BUILDING";
		
		private var _gameController : GameController;
		
		public var worldContainer : MovieClip;
		public var countdown : Countdown;
		public var infoBar :InfoBar;
		public var levelFinishedMenu : LevelFinishedMenu;
		public var levelFailedMenu : LevelFailedMenu;
		public var inGameMenu : InGameMenu;
		
		private static var _gameState : String;
		
		public function GameState() 
		{
			_id = State.GAME_STATE;
			
			_gameState = BUILDING;
			
			AnimationManager.setContainer(worldContainer);
			
			_gameController = new GameController(worldContainer);
			_gameController.addEventListener(TimeEvent.TIME_UPDATE, timeUpdate);
			_gameController.addEventListener(LevelEvent.LEVEL_FINISHED, levelFinished);
			_gameController.addEventListener(LevelEvent.LEVEL_FAILED, levelFailed);
			_gameController.addEventListener(LevelEvent.LEVEL_BUILD, levelBuild);
			_gameController.addEventListener(LevelEvent.LEVEL_START, levelStart);
			
			levelFailedMenu.addEventListener(MenuButtonEvent.RETRY, retryClicked);
			
			levelFinishedMenu.addEventListener(MenuButtonEvent.RETRY, retryClicked);
			levelFinishedMenu.addEventListener(MenuButtonEvent.PLAY_NEXT, playNextClicked);
			
			infoBar.addEventListener(MenuButtonEvent.RETRY, retryClicked);
			infoBar.addEventListener(MenuButtonEvent.PAUSE, pauseClicked);
			
			countdown.addEventListener(CountdownEvent.COUNTDOWN_START, countdownStart);
			countdown.addEventListener(CountdownEvent.COUNTDOWN_END, countdownEnd);
			
			inGameMenu.addEventListener(MenuButtonEvent.RETRY, retryClicked);
			inGameMenu.addEventListener(MenuButtonEvent.PAUSE, pauseClicked);
			
			levelFinishedMenu.hide();
			levelFailedMenu.hide();
			inGameMenu.hide();
		}
		
		private function countdownEnd(e:CountdownEvent):void 
		{
			_gameState == PLAYING;
			_gameController.startLevel();
		}
		
		private function countdownStart(e:CountdownEvent):void 
		{
			
			_gameState = COUNTDOWN;
		}
		
		private function pauseClicked(e:MenuButtonEvent):void 
		{
			trace("GameState: ", _gameState); 
			
			if (_gameState == PLAYING)
			{
				if (_gameController.togglePauseGame())
					inGameMenu.hide();
				else 
					inGameMenu.show();
			}
			else if (_gameState == COUNTDOWN)
			{
				countdown.pauseCountdown();
				_gameState = PAUSED_COUNTDOWN;
				inGameMenu.show();
			}
			else if (_gameState == PAUSED_COUNTDOWN)
			{
				countdown.resumeCountdown();
				_gameState = COUNTDOWN;
				inGameMenu.hide();
			}
			else
			{
				if (inGameMenu.hidden)
				{
					inGameMenu.show();
					countdown.enabled = false;
				}
				else
				{
					inGameMenu.hide();
					countdown.enabled = true;
				}
			}
		}
		
		private function levelFailed(e:LevelEvent):void 
		{
			_gameState = LEVEL_END;
			
			infoBar.enabled = false;
			levelFailedMenu.setMessage("You crashed and burned");
			//Wait for animation to finish
			TweenMax.delayedCall(1, levelFailedMenu.show);
		}
		
		private function playNextClicked(e:MenuButtonEvent):void 
		{
			_gameState = BUILDING;
			_gameController.playNextLevel();
		}
		
		private function retryClicked(e:MenuButtonEvent):void 
		{
			_gameState = BUILDING;
			_gameController.restartCurrentLevel();
		}
		
		override protected function activate():void 
		{
			_gameController.buildCurrentLevel();
			infoBar.show();
			hideAllMenus();
		}
		
		private function levelStart(e:LevelEvent):void 
		{
			_gameState = PLAYING;
			
			infoBar.enabled = true;
		}
		
		private function levelBuild(e:LevelEvent):void 
		{
			_gameState = PRE_COUNTDOWN;
			
			countdown.show();
			infoBar.enabled = true;
			infoBar.currentTime = 0;
			infoBar.awardTime = 0;
			infoBar.levelName = LevelContoller.getLevelFromID(e.levelID).name;
			
			hideAllMenus();
		}
		
		private function hideAllMenus():void
		{
			levelFailedMenu.hide();
			levelFinishedMenu.hide();
			inGameMenu.hide();
		}
		
		private function levelFinished(e:LevelEvent):void 
		{
			_gameState = LEVEL_END;
			infoBar.enabled = false;
			
			ScoreManager.gi().addScore(new Score(e.levelID, e.time, "Simon"));
			infoBar.currentTime = e.time;
			infoBar.awardTime = e.time;
				
			if (ScoreManager.gi().getAward(e.levelID, e.time) == 0)
			{
				levelFailedMenu.setMessage("You didn't make it in time");
				
				//Wait for animation to finish
				TweenMax.delayedCall(.5, levelFailedMenu.show);
			}
			else
			{
				levelFinishedMenu.setYourTime(e.time);
				levelFinishedMenu.setAward(ScoreManager.gi().getAward(e.levelID, e.time));
				
				//Wait for animation to finish
				TweenMax.delayedCall(.5, levelFinishedMenu.show);
				
				trace("Scores for level " + e.levelID);
				ArrayUtils.traceArrayProperty(ScoreManager.gi().getSortedScores(e.levelID), 'time', 'award');
			}
		}
		
		private function timeUpdate(e:TimeEvent):void 
		{
			infoBar.currentTime = e.time;
			infoBar.awardTime = e.time;
		}
		
		static public function get gameState():String { return _gameState; }
		
	}

}