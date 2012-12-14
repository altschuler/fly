package game.gui 
{
	import events.MenuButtonEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import game.GameController;
	import states.State;
	import states.StateManager;
	import utils.GameUtils;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class LevelFinishedMenu extends Sprite
	{
		public var retryButton : Sprite;
		public var nextLevelButton : Sprite;
		public var submitScoreButton : Sprite;
		public var levelSelectButton : Sprite;
		
		public var message : TextField;
		public var awardIcon : MovieClip;
		
		public var yourTime : TextField;
		
		public function LevelFinishedMenu() 
		{
			retryButton.addEventListener(MouseEvent.CLICK, retryButtonClicked);
			nextLevelButton.addEventListener(MouseEvent.CLICK, nextLevelClicked);
			submitScoreButton.addEventListener(MouseEvent.CLICK, submitScoreClicked);
			levelSelectButton.addEventListener(MouseEvent.CLICK, levelSelectClicked);
			
			GameUtils.makeHandCursor(retryButton, nextLevelButton, submitScoreButton, levelSelectButton);
			
			hide();
		}
		
		private function levelSelectClicked(e:MouseEvent):void 
		{
			StateManager.setState(State.LEVEL_SELECT_STATE);
		}
		
		public function setYourTime(value : uint):void
		{
			yourTime.text = GameUtils.millisecondsToTimeString(value);
		}
		
		public function setAward(award : uint):void
		{
			awardIcon.gotoAndStop(1 + award);
		}
		
		public function setMessage(msg : String):void
		{
			message.text = msg;
		}
		
		private function retryButtonClicked(e:MouseEvent):void
		{
			dispatchEvent(new MenuButtonEvent(MenuButtonEvent.RETRY));
			
			hide();
		}
		
		private function nextLevelClicked(e:MouseEvent):void
		{
			dispatchEvent(new MenuButtonEvent(MenuButtonEvent.PLAY_NEXT));
			
			hide();
		}
		
		private function submitScoreClicked(e:MouseEvent):void
		{
			//TODO submit score
		}
		
		public function hide():void
		{
			visible = false;
		}
		
		public function show():void
		{
			visible = true;
		}
		
	}

}