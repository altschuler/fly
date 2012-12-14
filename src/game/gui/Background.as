package game.gui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Background extends MovieClip
	{
		public static const WOOD : String = "bgWood";
		
		private var _currentBg : Bitmap;
		
		public function Background() 
		{
			
		}
		
		public function setBackground(id:String):void 
		{
			var bmd : BitmapData;
			switch (id) 
			{
				case WOOD: bmd = new WoodTiles_6x1();
			}
			
			var tileMap : BitmapData = new BitmapData(640, 480);
			
			var destPoint : Point = new Point(0,0);
			for (var i:int = 0; i < Math.ceil(480/40); i++) 
			{
				for (var j:int = 0; j < Math.ceil(640/40); j++) 
				{
					var ran : uint = Math.floor(Math.random() * 6);
					tileMap.copyPixels(bmd, new Rectangle(ran * 40, 0, 40, 40), destPoint);
					
					destPoint.x += 40;
				}
				
				destPoint.x = 0;
				destPoint.y += 40;
			}
			
			if (_currentBg) 
			{
				removeChild(_currentBg);
				_currentBg = null;
			}
			
			_currentBg = new Bitmap(tileMap);
			addChild(_currentBg);
		}
	}

}