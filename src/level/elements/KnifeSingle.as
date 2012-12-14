package level.elements 
{
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class KnifeSingle extends LevelElement
	{
		static public const SMALL_SCALE:Number = .72;
		static public const MEDIUM_SCALE:Number = .72;
		static public const LARGE_SCALE:Number = .72;
			
		public function KnifeSingle() 
		{
			_type = LevelElement.KNIFE_SINGLE;
			_deadly = true;
		}
		
	}

}