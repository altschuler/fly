package game.gui 
{
	import com.greensock.easing.Quad;
	import com.greensock.TweenMax;
	import events.MenuButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import game.GameController;
	import level.LevelContoller;
	import score.ScoreManager;
	import utils.GameUtils;
	import utils.GlobalStage;
	import utils.HotKeys;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class InfoBar extends Sprite
	{
		public var levelNameLabel : TextField;
		public var levelTimeLabel : TextField;
		public var awardTimeLabel : TextField;
		
		public var menuButton: Sprite;
		
		private var _enabled:Boolean;
		
		public function InfoBar() 
		{
			_enabled = false;
			
			menuButton.addEventListener(MouseEvent.CLICK, menuClick);
			
			GameUtils.makeHandCursor(menuButton);
		}
		
		private function menuClick(e:MouseEvent):void 
		{
			dispatchEvent(new MenuButtonEvent(MenuButtonEvent.PAUSE));
		}
		
		private function pauseClick():void
		{
			dispatchEvent(new MenuButtonEvent(MenuButtonEvent.PAUSE));
		}
		
		private function restartClick(e:MouseEvent = null):void 
		{
			if (_enabled) dispatchEvent(new MenuButtonEvent(MenuButtonEvent.RETRY));
		}
		
		public function set levelName (value : String):void
		{
			levelNameLabel.text = value;
		}
		
		public function set currentTime (value : uint):void
		{
			levelTimeLabel.text = GameUtils.millisecondsToTimeString(value);
		}
		
		public function set awardTime (value : uint):void
		{
			//TODO optimize by not getting the awards table each time, i.e. store it somewhere and do the coloring only thrice at max per round
			var t : int = ScoreManager.gi().getAwardTimes(GameController.currentLevelIndex)[0] - value;
			if (t < 0) 
			{
				t = ScoreManager.gi().getAwardTimes(GameController.currentLevelIndex)[1] - value;
			}
			if (t < 0) 
			{
				t = ScoreManager.gi().getAwardTimes(GameController.currentLevelIndex)[2] - value;
			}
			if (t < 0) 
			{
				awardTimeLabel.text = "Level failed - \"R\" for restart";
				return;
			}
			
			var f : TextFormat = awardTimeLabel.getTextFormat();
			var a : uint = ScoreManager.gi().getAward(GameController.currentLevelIndex, value)
			f.color = a  == 3 ? 0xFFCC00 : a == 2 ? 0xCCCCCC : a == 1 ? 0xCC3300 : 0xFF0000;
			awardTimeLabel.defaultTextFormat = f;
				
			awardTimeLabel.text = GameUtils.millisecondsToTimeString(t);
		}
		
		public function set enabled (value : Boolean) : void
		{
			//TODO maybe hide the bar here? (from outside)
			_enabled = value;
			
			if (_enabled)
			{				
				menuButton.addEventListener(MouseEvent.CLICK, menuClick);
				HotKeys.addKey(82, restartClick);
				HotKeys.addKey(80, pauseClick);
			}
			else
			{
				menuButton.removeEventListener(MouseEvent.CLICK, menuClick);
				HotKeys.removeKey(82);
				HotKeys.removeKey(80);
			}
		}
		
		public function show():void
		{
			TweenMax.to(this, .5, { y:440, ease:Quad.easeInOut } );
		}
		
		public function hide():void
		{
			TweenMax.to(this, .5, { y:480, ease:Quad.easeOut } );
		}
		
	}

}