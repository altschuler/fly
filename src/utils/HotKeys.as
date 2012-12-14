package utils 
{
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class HotKeys
	{
		private static var _keys : Object;
		
		//static
		{
			_keys = new Object();
			GlobalStage.reference.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		public static function addKey(keyCode:int, callback :Function) :void
		{
			_keys[keyCode] = callback;
		}
		
		public static function removeKey(keyCode:int):void 
		{
			delete _keys[keyCode];
		}
		
		public static function removeAllKeys():void 
		{
			_keys = new Object();
		}
		
		private static function keyDown(e:KeyboardEvent):void
		{
			var callback : Function = _keys[e.keyCode] as Function;
			if (callback != null) callback();
		}
		
	}

}