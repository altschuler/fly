package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class CountdownEvent extends Event
	{
		public static const COUNTDOWN_START : String = "COUNTDOWN_START";
		public static const COUNTDOWN_END : String = "COUNTDOWN_END";
		
		public function CountdownEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}