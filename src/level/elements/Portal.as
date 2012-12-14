package level.elements 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Portal extends LevelElement
	{
		private var _preventWarp : Boolean;
		private var _disabled : Boolean;
		private var _destPoint : Point;
		
		public function Portal(destPoint : Point, preventWarp : Boolean = true) 
		{
			_type = LevelElement.PORTAL;
			_deadly = false;
			_disabled = false;
			_destPoint = destPoint;
			_preventWarp = preventWarp;
		}
		
		public function get destPoint():Point { return _destPoint; }
		
		public function set destPoint(value:Point):void 
		{
			_destPoint = value;
		}
		
		public function get disabled():Boolean { return _disabled; }
		
		public function set disabled(value:Boolean):void 
		{
			_disabled = value;
		}
		
		public function get preventWarp():Boolean { return _preventWarp; }
		
	}

}