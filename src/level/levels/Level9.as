package level.levels 
{
	import com.actionsnippet.qbox.QuickBox2D;
	import flash.geom.Point;
	import game.hero.Hero;
	import level.elements.PlatformLong1;
	import level.elements.Portal;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Level9 extends Level
	{
		
		public function Level9() 
		{
			_name = "Triportangle";
			_ID = 8;
			
			_startPosition = new Point(320, 373);
			_targetPosition = new Point(320, 86);
			
			_map =  [
					[ 209, 224, 10, 439, Math.PI*(2/3),	false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , '()'],
					[ 317, 414, 10, 439, 0,				false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , '()'],
					[ 430, 225, 10, 439, Math.PI*(4/3),	false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , '()'],
					[ 209, 351, 10, 147, Math.PI*(4/3),	false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , '()'],
					[ 429, 351, 10, 147, Math.PI*(2/3),	false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , '()'],
					[ 319, 160, 10, 147, 0,				false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , '()'],
					[ 319, 287, 10, 293, 0, 			false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , '()'],
					[ 319, 287, 10, 293, Math.PI*(2/3),	false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , '()'],
					[ 319, 287, 10, 293, Math.PI*(4/3),	false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , '()']
				];
		}
		
		override public function build(world:QuickBox2D, hero : Hero):void
		{
			super.build(world, hero);
			//Dest points
			var t1 : Point = new Point(170, 370);
			var t2 : Point = new Point(247, 329);
			var t3 : Point = new Point(319, 370);
			var t4 : Point = new Point(393, 329);
			var t5 : Point = new Point(469, 370);
			var t6 : Point = new Point(245, 243);
			var t7 : Point = new Point(319, 203);
			var t8 : Point = new Point(395, 243);
			var t9 : Point = new Point(319, 115);
			
			//Triangle 1
			var p1_1 : Portal = new Portal(t5);
			var p1_2 : Portal = new Portal(t7);
			var p1_3 : Portal = new Portal(t7);
			
			//Triangle 2
			var p2_1 : Portal = new Portal(t3);
			var p2_2 : Portal = new Portal(t5);
			var p2_3 : Portal = new Portal(t6);
			
			//Triangle 3
			var p3_1 : Portal = new Portal(t6);
			var p3_2 : Portal = new Portal(t4);
			var p3_3 : Portal = new Portal(t2);
			
			//Triangle 4
			var p4_1 : Portal = new Portal(t6);
			var p4_2 : Portal = new Portal(t8);
			var p4_3 : Portal = new Portal(t6);
			
			//Triangle 5
			var p5_1 : Portal = new Portal(t3);
			var p5_2 : Portal = new Portal(t7);
			var p5_3 : Portal = new Portal(t1);
			
			//Triangle 6
			var p6_1 : Portal = new Portal(t1);
			var p6_2 : Portal = new Portal(t2);
			var p6_3 : Portal = new Portal(t7);
			
			//Triangle 7
			var p7_1 : Portal = new Portal(t4);
			var p7_2 : Portal = new Portal(t1);
			var p7_3 : Portal = new Portal(t5);
			
			//Triangle 8
			var p8_1 : Portal = new Portal(t9);
			var p8_2 : Portal = new Portal(t3);
			var p8_3 : Portal = new Portal(t2);
			
			var radius : Number = 5;
			
			//t1
			world.addCircle( { x:133, y:395, radius:radius, density:0, skin:p1_1 } );
			world.addCircle( { x:171, y:330, radius:radius, density:0, skin:p1_2 } );
			world.addCircle( { x:209, y:395, radius:radius, density:0, skin:p1_3 } );
			
			//t2
			world.addCircle( { x:247, y:370, radius:radius, density:0, skin:p2_1 } );
			world.addCircle( { x:209, y:305, radius:radius, density:0, skin:p2_2 } );
			world.addCircle( { x:285, y:305, radius:radius, density:0, skin:p2_3 } );
			
			//t3
			world.addCircle( { x:281, y:395, radius:radius, density:0, skin:p3_1 } );
			world.addCircle( { x:319, y:330, radius:radius, density:0, skin:p3_2 } );
			world.addCircle( { x:357, y:395, radius:radius, density:0, skin:p3_3 } );
			
			//t4
			world.addCircle( { x:393, y:370, radius:radius, density:0, skin:p4_1 } );
			world.addCircle( { x:355, y:305, radius:radius, density:0, skin:p4_2 } );
			world.addCircle( { x:431, y:305, radius:radius, density:0, skin:p4_3 } );
			
			//t5
			world.addCircle( { x:431, y:395, radius:radius, density:0, skin:p5_1 } );
			world.addCircle( { x:469, y:330, radius:radius, density:0, skin:p5_2 } );
			world.addCircle( { x:507, y:395, radius:radius, density:0, skin:p5_3 } );
			
			//t6
			world.addCircle( { x:207, y:265, radius:radius, density:0, skin:p6_1 } );
			world.addCircle( { x:245, y:200, radius:radius, density:0, skin:p6_2 } );
			world.addCircle( { x:283, y:265, radius:radius, density:0, skin:p6_3 } );
			
			//t7
			world.addCircle( { x:319, y:245, radius:radius, density:0, skin:p7_1 } );
			world.addCircle( { x:281, y:180, radius:radius, density:0, skin:p7_2 } );
			world.addCircle( { x:357, y:180, radius:radius, density:0, skin:p7_3 } );
			
			//t8
			world.addCircle( { x:357, y:265, radius:radius, density:0, skin:p8_1 } );
			world.addCircle( { x:395, y:200, radius:radius, density:0, skin:p8_2 } );
			world.addCircle( { x:433, y:265, radius:radius, density:0, skin:p8_3 } );
		}
		
	}

}