package game.hero 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import level.elements.LevelElement;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class HeroGraphics extends LevelElement
	{
		public var thrustUp : Sprite;
		public var thrustDown : Sprite;
		public var thrustLeft : Sprite;
		public var thrustRight : Sprite;
		
		public var v1 : MovieClip;
		public var v2 : MovieClip;
		public var v3 : MovieClip;
		public var v4 : MovieClip;
		public var v5 : MovieClip;
		public var v6 : MovieClip;
		public var v7 : MovieClip;
		public var v8 : MovieClip;
		private var _verts:Array;
		
		public function HeroGraphics() 
		{
			_type = LevelElement.HERO;
			_deadly = false;
			
			thrustUp.visible = thrustDown.visible = thrustLeft.visible = thrustRight.visible = false;
			
			setVerts();
		}
		
		private function setVerts():void
		{
			_verts = [v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y, v5.x, v5.y, v6.x, v6.y, v7.x, v7.y, v8.x, v8.y];
			
			removeChild(v1);
			removeChild(v2);
			removeChild(v3);
			removeChild(v4);
			removeChild(v5);
			removeChild(v6);
			removeChild(v7);
			removeChild(v8);
		}
		
		public function get verts():Array
		{
			return _verts
		}
		
		override public function set width(value:Number):void
		{
			//leave it
		}
		
		override public function set height(value:Number):void
		{
			//leave it
		}
		
		public function set enableThrustUp(value : Boolean):void
		{
			thrustUp.visible = value;
		}
		
		public function set enableThrustDown(value : Boolean):void
		{
			thrustDown.visible = value;
		}
		
		public function set enableThrustLeft(value : Boolean):void
		{
			thrustLeft.visible = value;
		}
		
		public function set enableThrustRight(value : Boolean):void
		{
			thrustRight.visible = value;
		}
		
	}

}