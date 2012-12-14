package level.levels 
{
	import Box2D.Common.Math.b2Vec2;
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickObject;
	import flash.geom.Point;
	import game.hero.Hero;
	import level.elements.KnifeDual;
	import level.elements.LevelElement;
	import level.elements.MetalBall;
	import level.elements.Platform1;
	import level.elements.PlatformLong1;
	import level.elements.StoneBall;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Level6 extends Level
	{
		
		public function Level6() 
		{
			_targetPosition = new Point(183, 418);
			_startPosition = new Point(68, 388);
			
			_name = "Mechs";
			_ID = 5;
			
			
			_map =  [
						[211, 412, 7, 54, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
						,[344, 412, 7, 54, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
						,[476, 412, 7, 54, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
						,[277, 366, 7, 54, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
						,[410, 366, 7, 54, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
						,[338, 341, 7, 370, 0, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
						
						,[150, 98, 16, 79, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
						,[523, 98, 16, 79, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
						,[336, 93, 16, 389, 0, false, 'SQUARE' , 0.5, 0.5, 0.5, PlatformLong1, -1]
						
						,[517, 433, 10, 10, 0, false, 'CIRCLE' , 0.5, 0.5, 0.5, StoneBall, -1]
					];
		}
		
		override public function build(world:QuickBox2D, hero : Hero):void 
		{
			super.build(world,  hero);
			
			var ball : QuickObject = world.addCircle( { x:150, y:185, radius:25, angularDamping:2, skin:MetalBall } );
			var pole : QuickObject = world.addBox( { x:150, y:327, width:224, height:16, angle:Math.PI / 2, density:0, skin:PlatformLong1 } );
			var board: QuickObject = world.addBox( { x:150, y:220, width:156, height:16, skin:PlatformLong1 } );
			
			var revolute : QuickObject = world.addJoint( { type:QuickBox2D.REVOLUTE, upperAngle:Math.PI/2, lowerAngle:0, a:board.body, b:pole.body, collideConnected:false } );
			
			var door: QuickObject = world.addBox( { x:527, y:388, width:97, height:7, angle:Math.PI/2, skin:Platform1 } );
			
			var pulley : QuickObject = world.addJoint( { type:QuickBox2D.PULLEY, a:ball.body, b:door.body, anchor2:new b2Vec2(527, 340), groundAnchor1:new b2Vec2(150, 125), groundAnchor2:new b2Vec2(527, 125)} );
			
			var knife1 : QuickObject = world.addPoly( { x:217, y:39, skin:KnifeDual, skinScale:KnifeDual.SMALL_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_DUAL, LevelElement.SIZE_SMALL)], groupIndex:-1 } );
			_world.addJoint( {type:QuickBox2D.REVOLUTE, a:knife1.body, b:_world.w.GetGroundBody(), x1:254, y1:48, maxMotorTorque:1000, enableMotor:true, motorSpeed:2 } );
			
			var knife2 : QuickObject = world.addPoly( { x:379, y:39, skin:KnifeDual, skinScale:KnifeDual.SMALL_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_DUAL, LevelElement.SIZE_SMALL)], groupIndex:-1 } );
			_world.addJoint( {type:QuickBox2D.REVOLUTE, a:knife2.body, b:_world.w.GetGroundBody(), x1:416, y1:48, maxMotorTorque:1000, enableMotor:true, motorSpeed:-2 } );
			
		}
		
	}

}