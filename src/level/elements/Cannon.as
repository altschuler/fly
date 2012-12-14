package level.elements 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Cannon extends LevelElement
	{
		public var tip : MovieClip;
		
		public function Cannon() 
		{
			_type = LevelElement.CANNON;
			_deadly = false;
		}
		
	}

}