package states.mainmenu
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import states.State;
	import states.StateManager;
	import utils.GameUtils;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class MainMenuState extends State
	{
		public var playButton : Sprite;
		public var highscoreButton : Sprite;
		public var levelSelectButton : Sprite;
		
		public function MainMenuState() 
		{
			_id = MAIN_MENU_STATE;
			
			playButton.addEventListener(MouseEvent.CLICK, playButtonClick);
			highscoreButton.addEventListener(MouseEvent.CLICK, highscoreButtonClick);
			levelSelectButton.addEventListener(MouseEvent.CLICK, levelSelectButtonClick);
			
			GameUtils.makeHandCursor(playButton, highscoreButton, levelSelectButton);	
		}
		
		private function levelSelectButtonClick(e:MouseEvent):void 
		{
			StateManager.setState(State.LEVEL_SELECT_STATE);
		}
		
		private function highscoreButtonClick(e:MouseEvent):void
		{
			//StateManager.setState(State.HIGHSCORE_STATE);
		}
		
		private function playButtonClick(e:MouseEvent):void
		{
			StateManager.setState(State.GAME_STATE);
		}
		
	}

}