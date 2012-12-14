package level.elements 
{
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class KnifeSingleBall extends LevelElement
	{
		static public const SMALL_SCALE:Number = .72;
		static public const MEDIUM_SCALE:Number = .72;
		static public const LARGE_SCALE:Number = .72;
		
		public function KnifeSingleBall() 
		{
			_type = LevelElement.KNIFE_SINGLE_BALL;
			_deadly = true;
		}
		
	}

}