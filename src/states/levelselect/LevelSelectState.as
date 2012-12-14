package states.levelselect
{
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import game.GameController;
	import level.LevelContoller;
	import score.ScoreManager;
	import states.State;
	import states.StateManager;
	import utils.GameUtils;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class LevelSelectState extends State
	{	
		private var _icons : Array;
		
		public var mainMenuButton : MovieClip;
		public var levelTitleLabel : TextField;
		public var levelInfoLabel : TextField;
		
		public function LevelSelectState() 
		{
			_id = LEVEL_SELECT_STATE;
			
			mainMenuButton.addEventListener(MouseEvent.CLICK, mainMenuButtonClicked);
			GameUtils.makeHandCursor(mainMenuButton);
			
			setupIcons();
		}
		
		private function mainMenuButtonClicked(e:MouseEvent):void 
		{
			StateManager.setState(State.MAIN_MENU_STATE);
		}
		
		override protected function activate():void
		{
			for (var i:uint = 0; i < _icons.length; i++)
			{
				var icon : LevelIcon = _icons[i];
				if (i == 0) icon.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
				icon.alpha = 0;
				icon.update();
				TweenMax.to(icon, .1, { delay:i/10, alpha:1 } );
			}
			
			
		}
		
		private function setupIcons():void
		{
			_icons = new Array();
			
			var offsetX: Number = 0;
			var offsetY: Number = 0;
			
			for (var i:uint = 0; i < LevelContoller.getLevels().length; i++)
			{
				var icon : LevelIcon = new LevelIcon(i, LevelContoller.getLevelFromID(i).name, false);
				icon.x = 40 + offsetX;
				icon.y = 70 + offsetY;
				icon.update();
				icon.addEventListener(MouseEvent.CLICK, iconClick);
				icon.addEventListener(MouseEvent.MOUSE_OVER, iconOver);
				
				offsetX += 90;
				if (i % 5 == 0 && i != 0)
				{
					offsetX = 0;
					offsetY += 90;
				}
				
				GameUtils.makeHandCursor(icon);
				_icons.push(icon);
				addChild(icon);
			}
		}
		
		private function iconOver(e:MouseEvent):void 
		{
			var icon : LevelIcon = e.currentTarget as LevelIcon;
			
			levelTitleLabel.text = "Level " + String(icon.levelID + 1) + " - " + icon.levelName;
			
			if (icon.locked)
			{
				levelInfoLabel.text = "Level locked! Get a bronze medal in level " + String(icon.levelID) + " to unlock";
			}
			else
			{	
				levelInfoLabel.text = "";
				
				var award : uint = ScoreManager.gi().getMaxAward(icon.levelID);
				var awardText :String = award == 1 ? "BRONZE" : award == 2 ? "SILVER" : award == 3 ? "GOLD" : "NO AWARD";
				var bestTime : int = ScoreManager.gi().getBestTime(icon.levelID);
				trace(bestTime);
				if (bestTime != -1) 
					levelInfoLabel.text = "Best time: " + GameUtils.millisecondsToTimeString(bestTime) + "(" + awardText + ")\n";
				
				if (award == 0)
					levelInfoLabel.appendText("Beat " + GameUtils.millisecondsToTimeString(ScoreManager.gi().getAwardTimes(icon.levelID)[1]) + " for BRONZE award and to unlock next level");
				else if (award == 1)
					levelInfoLabel.appendText("Beat " + GameUtils.millisecondsToTimeString(ScoreManager.gi().getAwardTimes(icon.levelID)[1]) + " for SILVER award");
				else if (award == 2)
					levelInfoLabel.appendText("Beat " + GameUtils.millisecondsToTimeString(ScoreManager.gi().getAwardTimes(icon.levelID)[0]) + " for GOLD award");
			}
				
		}
		
		private function iconClick(e:MouseEvent):void 
		{
			var icon : LevelIcon = e.currentTarget as LevelIcon;
			//if (!icon.locked)
			if (true)
			{
				GameController.currentLevelIndex = icon.levelID;
				StateManager.setState(State.GAME_STATE);				
			}
		}
	}
}