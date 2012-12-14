package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class GameEvent extends Event
	{
		public static const GAME_START : String = "GAME_START";
		public static const GAME_END : String = "GAME_END";
		
		public function GameEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}