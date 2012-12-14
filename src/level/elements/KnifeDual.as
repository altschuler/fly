package level.elements 
{
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class KnifeDual extends LevelElement
	{
		static public const SMALL_SCALE:Number = .454;
		static public const MEDIUM_SCALE:Number = .624;
		static public const LARGE_SCALE:Number = .624;

		public function KnifeDual() 
		{
			_type = LevelElement.KNIFE_DUAL;
			_deadly = true;
		}
		
	}

}