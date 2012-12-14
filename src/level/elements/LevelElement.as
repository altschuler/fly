package level.elements 
{
	import com.actionsnippet.qbox.QuickObject;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class LevelElement extends MovieClip
	{	
		public static const BALL 				: String = "BALL";
		public static const PLATFORM_WOOD 		: String = "PLATFORM_WOOD";
		public static const PLATFORM_METAL 		: String = "PLATFORM_METAL";
		public static const BOX_METAL 			: String = "BOX_METAL";
		public static const BOX_STONE 			: String = "BOX_STONE";
		public static const PORTAL 				: String = "PORTAL";
		public static const HANDLE 				: String = "HANDLE";
		public static const FAN 				: String = "FAN";
		public static const CANNON 				: String = "CANNON";
		public static const KNIFE_SINGLE_BALL 	: String = "KNIFE_SINGLE_BALL";
		public static const KNIFE_SINGLE 		: String = "KNIFE_SINGLE";
		public static const KNIFE_DUAL 			: String = "KNIFE_DUAL";
		public static const SENSOR 				: String = "SENSOR";
		
		public static const FRAME 				: String = "FRAME";
		public static const TARGET 				: String = "TARGET";
		public static const HERO 				: String = "HERO";
		
		public static const SIZE_SMALL 			: String = "SIZE_SMALL";
		public static const SIZE_MEDIUM 		: String = "SIZE_MEDIUM";
		public static const SIZE_LARGE 			: String = "SIZE_LARGE";
		
		protected var _type : String;
		protected var _deadly : Boolean;
		protected var _qo : QuickObject;
		
		public var inner : DisplayObject;
		
		public function LevelElement() 
		{
			
			//TODO do this?
			cacheAsBitmap = true;
			_deadly = false;
		}
		
		public function get type():String { return _type; }
		
		public function get deadly():Boolean { return _deadly; }
		
		public function get qo():QuickObject { return _qo; }
		
		public function set qo(value:QuickObject):void 
		{
			_qo = value;
		}
		
		static public function getVerts(ID : String, size : String = SIZE_MEDIUM):Array
		{
			switch (ID + size) 
			{
				case KNIFE_SINGLE_BALL + SIZE_MEDIUM:
					return [0, 10, 29, 1, 45, 1, 53, 6, 53, 14, 45, 19, 29, 19];
					
				case KNIFE_SINGLE + SIZE_MEDIUM:
					return [0,10, 29,1, 40,1, 40,19, 29,19];
					
				case KNIFE_DUAL + SIZE_MEDIUM:
					return [0,11, 33,1, 70,1, 102,12, 70,21, 33,21];
					
				case KNIFE_DUAL + SIZE_SMALL:
					return [0*.72,11*.72, 33*.72,1*.72, 70*.72,1*.72, 102*.72,12*.72, 70*.72,21*.72, 33*.72,21*.72];
			}
			
			return null;
		}
		
	}

}