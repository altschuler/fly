package game.gui 
{
	import events.MenuButtonEvent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import states.State;
	import states.StateManager;
	import utils.GameUtils;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class InGameMenu extends MovieClip
	{
		public var retryButton : MovieClip;
		public var levelSelectButton : MovieClip;
		public var mainMenuButton : MovieClip;
		public var resumeButton : MovieClip;
		
		private var _hidden:Boolean;
		
		public function InGameMenu() 
		{
			retryButton.addEventListener(MouseEvent.CLICK, retryButtonClick);
			levelSelectButton.addEventListener(MouseEvent.CLICK, levelSelectButtonClick);
			mainMenuButton.addEventListener(MouseEvent.CLICK, mainMenuButtonClick);
			resumeButton.addEventListener(MouseEvent.CLICK, resumeButtonClick);
			
			GameUtils.makeHandCursor(retryButton, levelSelectButton, mainMenuButton, resumeButton);
			
			hide();
		}
		
		private function resumeButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new MenuButtonEvent(MenuButtonEvent.PAUSE));
		}
		
		private function mainMenuButtonClick(e:MouseEvent):void 
		{
			StateManager.setState(State.MAIN_MENU_STATE);
		}
		
		private function levelSelectButtonClick(e:MouseEvent):void 
		{
			StateManager.setState(State.LEVEL_SELECT_STATE);
		}
		
		private function retryButtonClick(e:MouseEvent):void 
		{
			dispatchEvent(new MenuButtonEvent(MenuButtonEvent.RETRY));
		}
		
		public function hide():void
		{
			visible = false;
			_hidden = true;
		}
		
		public function show():void
		{
			visible = true;
			_hidden = false;
		}
		
		public function get hidden():Boolean { return _hidden; }
	}
}