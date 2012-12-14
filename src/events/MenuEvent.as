package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class MenuEvent extends Event
	{
		public static const MAIN_MENU_HIDE : String = "MAIN_MENU_HIDE";
		public static const MAIN_MENU_SHOW : String = "MAIN_MENU_SHOW";
		
		public static const GAME_MENU_SHOW : String = "GAME_MENU_SHOW";
		public static const GAME_MENU_HIDE : String = "GAME_MENU_HIDE";
		
		public function MenuEvent(type:String, bubbles:Boolean = false, cancelable : Boolean = false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}