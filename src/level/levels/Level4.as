package level.levels 
{
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickObject;
	import flash.geom.Point;
	import game.hero.Hero;
	import level.elements.Platform1;
	import level.elements.PlatformLong1;
	import level.elements.StoneBall;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Level4 extends Level
	{
		
		public function Level4() 
		{
			_name = "The Right Fall";
			_ID = 3;
			
			_startPosition = new Point(60, 400);
			_targetPosition = new Point(570, 290);
			_map = [
[645.0000,220.0000,440.00,10.00,0.0000,false,'SQUARE' , 0.5,0.5,0.5,'iq', '()']
,[320.0000,445.0000,10.00,640.00,0.0000,false,'SQUARE' , 0.5,0.5,0.5,'iq', '()']
,[18.9998,394.0000,10.00,90.00,-1.5708,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[68.0000,344.0000,10.00,100.00,0.0000,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[117.9998,394.0000,10.00,90.00,-1.5708,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[19.9998,293.0000,10.00,90.00,-1.5708,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[117.9998,293.0000,10.00,90.00,-1.5708,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[69.0000,243.0000,10.00,100.00,0.0000,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[520.9998,394.0000,10.00,90.00,-1.5708,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[620.9998,394.0000,10.00,90.00,-1.5708,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[571.0000,344.0000,10.00,100.00,0.0000,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[520.9998,293.0000,10.00,90.00,-1.5708,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[620.9998,293.0000,10.00,90.00,-1.5708,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[571.0000,243.0000,10.00,100.00,0.0000,true,'SQUARE' , 0.5,0.5,0.5,'P', '()']
,[495.5498,286.5000,7.00,131.00,-1.5708,false,'SQUARE' , 0.5,0.5,0.5,'PL', '()']
,[495.4998,391.0000,7.00,88.00,-1.5708,true,'SQUARE' , 0.5,0.5,0.5,'iq', '()']
];
		}
		
		override public function build(world:QuickBox2D, hero : Hero):void
		{
			super.build(world, hero);
			
			/*var cn : Number = 320;
			
			world.addBox( { x:cn, y: 195, width:250, height:16, skin:PlatformLong1 } );
			world.addBox( { x:cn, y: 249, width:250, height:16, skin:PlatformLong1 } );
			world.addBox( { x:cn, y: 303, width:250, height:16, skin:PlatformLong1 } );
			world.addBox( { x:cn, y: 393, width:130, height:16, skin:Platform1 } );
			
			world.addBox( { x:cn+120, y: 376, width:130, height:16, angle:Math.PI/2, skin:Platform1 } );
			world.addBox( { x:cn-120, y: 376, width:130, height:16, angle:Math.PI/2, skin:Platform1 } );
			
			world.addCircle( { x:cn, y:364, radius:18, skin:StoneBall } );
			world.addCircle( { x:cn + 50, y:421, radius:18, skin:StoneBall } );
			world.addCircle( { x:cn - 50, y:421, radius:18, skin:StoneBall } );
			
			world.addCircle( { x:cn + 80, y:220, radius:18, skin:StoneBall } );
			world.addCircle( { x:cn - 80, y:220, radius:18, skin:StoneBall } );
			world.addCircle( { x:cn + 80, y:276, radius:18, skin:StoneBall } );
			world.addCircle( { x:cn - 80, y:276, radius:18, skin:StoneBall } );*/
			
			_world = world;
		}
	}
}