package utils 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class GameUtils
	{
		
		static public function millisecondsToTimeString(milliseconds:uint) :String
		{
			//TODO can be optimized
			var mil:int = int(milliseconds % 1000);
			var sec:int = ((milliseconds % 60000) - (milliseconds % 1000))/1000;
			var min:int = (milliseconds - (milliseconds % 60000)) / 60000;
			
			var milString : String = mil < 10 ? "0" + mil : String(mil);
			var secString : String = sec < 10 ? "0" + sec : String(sec);
			var minString : String = min < 10 ? "0" + min : String(min);
			
			return minString + ":" + secString + "." + milString.substr(0, 2);
		}
		
		static public function makeHandCursor(...buttons):void
		{
			for each (var s : Sprite in buttons)
			{
				s.buttonMode = s.useHandCursor = true;
			}
		}
		
	}

}