package level.levels 
{
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickObject;
	import flash.geom.Point;
	import game.hero.Hero;
	import level.elements.Cannon;
	import level.elements.MetalBox;
	import level.elements.RoundHandle;
	import level.elements.WoodBox;
	import level.elements.WoodBoxLong;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Level7 extends Level
	{
		
		public function Level7() 
		{
			_targetPosition = new Point(570, 400);
			_startPosition = new Point(150, 388);
			
			_name = "Gun";
			_ID = 6;
			
			_map =  [
						[475, 330, 220, 48,0, false, 'SQUARE' , 0.5, 0.5, 0.5, WoodBoxLong, -1],
						[475, 53, 86, 48,0, false, 'SQUARE' , 0.5, 0.5, 0.5, WoodBox, -1]
					];
		}
		
		override public function build(world:QuickBox2D, hero : Hero):void 
		{
			super.build(world,  hero);
			
			var handleV:QuickObject = world.addBox( { width:100, height:10, x:0, y:0, angle:Math.PI/2, groupIndex:-1} );
			var handleH:QuickObject = world.addBox( { width:100, height:10, x:0, y:0, groupIndex:-1} );
			var handle : QuickObject = world.addGroup( { objects:[handleH, handleV], angularDamping:3, x:240, y:440, skin:RoundHandle, groupIndex:-1 } );
			
			var handleJoint : QuickObject = world.addJoint( { type:QuickBox2D.REVOLUTE, b:world.w.GetGroundBody(), a:handle.body, x1:240, y1:440} );
			
			var box1:QuickObject = world.addBox( { width:48, height:42, x:475, y:117, skin:MetalBox } );
			var box2:QuickObject = world.addBox( { width:48, height:42, x:475, y:158, skin:MetalBox } );
			var box3:QuickObject = world.addBox( { width:48, height:42, x:475, y:199, skin:MetalBox } );
			
			var cannon : QuickObject = world.addBox( { width:70, height:53, x:70, y:380, skin:Cannon, groupIndex:-1 } );
			var cannonJoint : QuickObject = world.addJoint( { type:QuickBox2D.REVOLUTE, b:cannon.body, a:world.w.GetGroundBody(), x1:cannon.body.GetPosition().x, y1:cannon.body.GetPosition().y } );
			
			var gear : QuickObject = world.addJoint( { type:QuickBox2D.GEAR, a:handle.body, b:cannon.body, joint1:handleJoint.joint, joint2:cannonJoint.joint } );
		
			
		}
		
	}

}