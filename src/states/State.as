package states 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class State extends MovieClip
	{
		public static const MAIN_MENU_STATE : String = "MAIN MENU STATE";
		public static const LEVEL_SELECT_STATE : String = "LEVEL SELECT STATE";
		public static const GAME_STATE : String = "GAME STATE";
		
		protected var _id : String;
		
		public function show():void
		{
			this.visible = true;
			activate();
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		protected function activate():void
		{
		}
		
		protected function deactivate():void
		{
			
		}
		
		public function get id():String { return _id; }
		
	}

}