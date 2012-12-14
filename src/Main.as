package 
{
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.ScalePlugin;
	import com.greensock.plugins.TweenPlugin;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import game.gui.Background;
	import score.ScoreManager;
	import states.game.GameState;
	import states.levelselect.LevelSelectState;
	import states.mainmenu.MainMenuState;
	import states.State;
	import states.StateManager;
	import uk.co.bigroom.input.KeyPoll;
	import utils.GlobalStage;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Main extends MovieClip 
	{		
		public var background : Background;
		public var stateContainer : MovieClip;
		private var l:URLLoader;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			
			GlobalStage.reference = stage;
			TweenPlugin.activate([ScalePlugin, AutoAlphaPlugin]);
			KeyPoll.init(stage);
			ScoreManager.gi().loadScores();
			//TODO achievements: die in 1 second, dont touch anything, finish in 13.37]
			//TODO UPGRADES: booster, shields of minor/major/bomb/epic
			//TODO replays, achievements
			//TODO high score (local and global), switches, backgrounds
			//TODO time fix (very high numbers)
			//TODO dont use delayedCall in timeStepSequences!
			
			background.setBackground(Background.WOOD);
			
			StateManager.init(stateContainer);
			StateManager.addState(new MainMenuState());
			StateManager.addState(new LevelSelectState());
			StateManager.addState(new GameState());
			
			StateManager.setState(State.MAIN_MENU_STATE);
		}
	}
}