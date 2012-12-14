package level.levels 
{
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickObject;
	import flash.geom.Point;
	import game.hero.Hero;
	import level.elements.Fan1;
	import level.elements.Fan2;
	import level.elements.Platform1;
	import level.elements.PlatformMetal;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Level3 extends Level
	{
		
		public function Level3() 
		{
			_name = "VENTILATOR SHAFTS";
			_ID = 2;
			
			_startPosition = new Point(370, 420);
			_targetPosition = new Point(285, 40);
		}
		
		override public function build(world:QuickBox2D, hero : Hero):void
		{
			_world = world;
			super.build(world, hero);
			
			var pos1 : Point = new Point(178, 275);
			var pos2 : Point = new Point(456, 175);
			
			var motor1 : QuickObject = world.addCircle( { x:0, y:0, radius:10 } );
			var cross1_1 : QuickObject = world.addBox( { x:0, y:0, width:10, height:250 } );
			var cross1_2 : QuickObject = world.addBox( { x:0, y:0, width:250, height:10 } );
			var group1 : QuickObject = world.addGroup( { objects: [motor1, cross1_1, cross1_2], x:pos1.x, y:pos1.y, skin:Fan1} );
			world.addJoint( { type:"revolute", a:group1.body, b:world.w.GetGroundBody(), maxMotorTorque:1000, enableMotor:true, motorSpeed:-.8 } );
			
			var motor2 : QuickObject = world.addCircle( { x:0, y:0, radius:10 } );
			var cross2_1 : QuickObject = world.addBox( { x:0, y:0, width:10, height:250 } );
			var cross2_2 : QuickObject = world.addBox( { x:0, y:0, width:10, height:250, angle:(1/3) * Math.PI } );
			var cross2_3 : QuickObject = world.addBox( { x:0, y:0, width:10, height:250, angle:(2/3) * Math.PI } );
			var group2 : QuickObject = world.addGroup( { objects: [motor2, cross2_1, cross2_2, cross2_3], x:pos2.x, y:pos2.y, skin:Fan2} );
			world.addJoint( { type:"revolute", a:group2.body, b:world.w.GetGroundBody(), maxMotorTorque:1000, enableMotor:true, motorSpeed:1 } );
			
			var c1 : QuickObject = createSegCircle(135, 16, 7, {density:0, x:pos1.x, y:pos1.y, skin:Platform1, segSkin:true}, [15,1,2]);
			var c2 : QuickObject = createSegCircle(135, 16, 7, {density:0, x:pos2.x, y:pos2.y, skin:Platform1, segSkin:true}, [9,10,7]);
			
			var upperTunnel : QuickObject = world.addBox( { x:307, y: 201, width:36, height:7, skin:Platform1, density:0 } );
			var lowerTunnel : QuickObject = world.addBox( { x:326, y: 249, width:36, height:7, skin:Platform1, density:0 } );
			
			var entranceLower1:QuickObject = world.addBox( { width:78, height:7, x:278, y:414, angle:Math.PI/4, skin:Platform1, density:0 } );
			var entranceUpper1:QuickObject = world.addBox( { width:198, height:7, x:380, y:370, angle:Math.PI/4, skin:Platform1, density:0 } );
			
			var entranceUpper2:QuickObject = world.addBox( { width:78, height:7, x:356, y:36, angle:Math.PI/4, skin:Platform1, density:0 } );
			var entranceLower2:QuickObject = world.addBox( { width:198, height:7, x:255, y:80, angle:Math.PI/4, skin:Platform1, density:0 } );
			
			//var allStatics : QuickObject = world.addGroup({objects:[c1, c2, upperTunnel, lowerTunnel, entranceLower1, entranceLower2, entranceUpper1, entranceUpper2]});
		}
	}
}