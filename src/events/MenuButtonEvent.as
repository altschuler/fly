package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class MenuButtonEvent extends Event
	{
		public static const RETRY : String = "MenuButtonEvent.RETRY";
		public static const PLAY_NEXT : String = "MenuButtonEvent.PLAY_NEXT";
		public static const PAUSE : String = "MenuButtonEvent.PAUSE";
		public static const IN_GAME_MENU : String = "MenuButtonEvent.IN_GAME_MENU";
		
		public function MenuButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}