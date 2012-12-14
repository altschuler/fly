package game.gui 
{
	import events.MenuButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import game.GameController;
	import states.State;
	import states.StateManager;
	import utils.GameUtils;
	import utils.HotKeys;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class LevelFailedMenu extends Sprite
	{
		public var retryButton : Sprite;
		public var levelSelectButton : Sprite;
		
		public var message : TextField;
		
		public function LevelFailedMenu() 
		{
			retryButton.addEventListener(MouseEvent.CLICK, retryButtonClicked);
			levelSelectButton.addEventListener(MouseEvent.CLICK, levelSelectClicked);
			
			GameUtils.makeHandCursor(retryButton, levelSelectButton);
			
			hide();
		}
		
		public function setMessage(msg : String):void
		{
			message.text = msg;
		}
		
		private function levelSelectClicked(e:MouseEvent = null):void 
		{
			StateManager.setState(State.LEVEL_SELECT_STATE);
			
			hide();
		}
		
		private function retryButtonClicked(e:MouseEvent = null):void
		{
			dispatchEvent(new MenuButtonEvent(MenuButtonEvent.RETRY));
			
			hide();
		}
		
		public function hide():void
		{
			visible = false;
			
			HotKeys.removeKey(82);
		}
		
		public function show():void
		{
			visible = true;
			
			HotKeys.addKey(82, retryButtonClicked);
		}
		
	}

}