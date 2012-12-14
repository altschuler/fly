package level.levels 
{
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickContacts;
	import com.actionsnippet.qbox.QuickObject;
	import com.greensock.easing.Quad;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import game.animation.AnimationManager;
	import game.hero.Hero;
	import level.elements.FireBall;
	import level.elements.KnifeDual;
	import level.elements.KnifeSingle;
	import level.elements.KnifeSingleBall;
	import level.elements.LevelElement;
	import level.elements.Platform1;
	import level.elements.PlatformLong1;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Level5 extends Level
	{		
		private var _balls : Dictionary;
		
		public function Level5() 
		{
			_balls = new Dictionary(true);
			
			_name = "THE GRUESOME MAZE";
			_ID = 4;
			
			_startPosition = new Point(600, 420);
			_targetPosition = new Point(40, 40);
		}
		
		override public function build(world:QuickBox2D, hero : Hero):void
		{
			_map =  [
						[ 604.45 , 389.95 , 10 , 55 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 555.45 , 336 , 10 , 55 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 502.45 , 281 , 10 , 55 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 555.45 , 229 , 10 , 55 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 555.45 , 69 , 10 , 55 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 502.45 , 123 , 10 , 55 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 398.45 , 336 , 10 , 55 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 246.5 , 229 , 10 , 55 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 296.5 , 123 , 10 , 55 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 90.5 , 336 , 10 , 55 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 529.95 , 254.5 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 579.95 , 309 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 323 , 361.95 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 66 , 361.95 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 116 , 309 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 116 , 147 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 143.4 , 69.2 , 10 , 162.8 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 171 , 95 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 194.5 , 123 , 10 , 55 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 219.5 , 147 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 66 , 95 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 221.5 , 389.95 , 10 , 216 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 117.35 , 229.5 , 10 , 111 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 65.5 , 284 , 10 , 111 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 374 , 174 , 10 , 111 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 426.45 , 229 , 10 , 111 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 322.45 , 281 , 10 , 111 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 270.95 , 334.5 , 10 , 117 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 220 , 282 , 10 , 117 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 479.95 , 334.45 , 10 , 117 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 530.95 , 386.45 , 10 , 111 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 374.95 , 386.45 , 10 , 111 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 425.8 , 123.35 , 10 , 111 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 167.85 , 309.4 , 10 , 170.8 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 428.85 , 309.4 , 10 , 170.8 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 476.95 , 148.6 , 10 , 170.8 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 270.95 , 203 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 374.95 , 68 , 10 , 116 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 272.95 , 68 , 10 , 116 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 526.95 , 148 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 529.95 , 41 , 10 , 60 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, Platform1 , -1],
						[ 577.95 , 147.6 , 10 , 170.8 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 323.5 , 176 , 10 , 216.8 , Math.PI/2 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1],
						[ 143.6 , 174 , 10 , 264.7 , 0 ,false,'SQUARE' , 0.5,0.5,0.5, PlatformLong1 , -1]
					];
			super.build(world, hero);
			
			var knife1 : QuickObject = _world.addPoly( { x:202-27, y:335-10, skin: KnifeSingleBall, skinScale:KnifeSingleBall.MEDIUM_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_SINGLE_BALL)], groupIndex:-1 } ); 
			_world.addJoint( {type:QuickBox2D.REVOLUTE, a:knife1.body, b:_world.w.GetGroundBody(), x1:219, y1:335, maxMotorTorque:1000, enableMotor:true, motorSpeed:1.6 } );
			
			var knife2 : QuickObject = _world.addPoly( { x:356-27, y:227-10, skin: KnifeSingleBall, skinScale:KnifeSingleBall.MEDIUM_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_SINGLE_BALL)], groupIndex:-1 } ); 
			_world.addJoint( {type:QuickBox2D.REVOLUTE, a:knife2.body, b:_world.w.GetGroundBody(), x1:373, y1:227, maxMotorTorque:1000, enableMotor:true, motorSpeed:2 } );
		
			var knife3 : QuickObject = _world.addPoly( { x:203-27, y:68-10, skin: KnifeSingleBall, skinScale:KnifeSingleBall.MEDIUM_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_SINGLE_BALL)], groupIndex:-1 } ); 
			_world.addJoint( {type:QuickBox2D.REVOLUTE, a:knife3.body, b:_world.w.GetGroundBody(), x1:220, y1:68, maxMotorTorque:1000, enableMotor:true, motorSpeed:1.8 } );
		
			var knife4 : QuickObject = world.addPoly( { x:454-51, y:440-12, skin:KnifeDual, skinScale:KnifeDual.MEDIUM_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_DUAL)], groupIndex:-1 } );
			_world.addJoint( {type:QuickBox2D.REVOLUTE, a:knife4.body, b:_world.w.GetGroundBody(), x1:454, y1:440, maxMotorTorque:1000, enableMotor:true, motorSpeed:2 } );
			
			var spike1 : QuickObject = _world.addPoly( { angle:Math.PI/2, x:290, y:418-10, skin:KnifeSingle, skinScale:KnifeSingle.MEDIUM_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_SINGLE)], density:0, groupIndex:-1 } );
			var spike2 : QuickObject = _world.addPoly( { angle:Math.PI/2, x:290-33, y:418-10, skin:KnifeSingle, skinScale:KnifeSingle.MEDIUM_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_SINGLE)], density:0, groupIndex:-1 } );
			var spike3 : QuickObject = _world.addPoly( { angle:Math.PI/2, x:290-66, y:418-10, skin:KnifeSingle, skinScale:KnifeSingle.MEDIUM_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_SINGLE)], density:0, groupIndex:-1 } );
			var spike4 : QuickObject = _world.addPoly( { angle:Math.PI/2, x:290-99, y:418-10, skin:KnifeSingle, skinScale:KnifeSingle.MEDIUM_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_SINGLE)], density:0, groupIndex:-1 } );
			var spike5 : QuickObject = _world.addPoly( { angle:Math.PI/2, x:290-132, y:418-10, skin:KnifeSingle, skinScale:KnifeSingle.MEDIUM_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_SINGLE)], density:0, groupIndex:-1 } );

			var _tl:TimelineMax = new TimelineMax( { repeat: -1, repeatDelay:1 } );
			_tl.insertMultiple(TweenMax.allTo([spike1, spike2, spike3, spike4, spike5], .5, { y:443, repeat:1, repeatDelay:1, yoyo:true }, .2))
			
			var spike : QuickObject = _world.addPoly( { angle:Math.PI, x:54, y:280, skin:KnifeSingle, skinScale:KnifeSingle.MEDIUM_SCALE, verts:[LevelElement.getVerts(LevelElement.KNIFE_SINGLE)], density:0, groupIndex:-1 } );
			
			var _tl2:TimelineMax = new TimelineMax( { repeat: -1, yoyo:true } );
			_tl2.append(TweenMax.to(spike, 2, { y:204, ease:Quad.easeInOut }))
			
			_tweens[_tl] = _tl;
			_tweens[_tl2] = _tl2;
			
			world.addTimeStepSequence( { time:1, callback:createCircle } );
			
		}
		
		override protected function contactAdd(e:Event):void 
		{
			super.contactAdd(e);
			
			
			var le1 : LevelElement = _contacts.currentPoint.shape1.m_body.m_userData;
			var le2 : LevelElement = _contacts.currentPoint.shape2.m_body.m_userData;
			
			if (le1.type == LevelElement.BALL && le2.type == LevelElement.PLATFORM_WOOD)
			{
				if (le2.x > 600 && le2.y > 380) destroyCircle(_balls[_contacts.currentPoint.shape1]);
			}
			else if (le2.type == LevelElement.BALL && le1.type == LevelElement.PLATFORM_WOOD)
			{
				if (le1.x > 600 && le1.y > 380) destroyCircle(_balls[_contacts.currentPoint.shape2]);
			}
			
			
			dispatchEvent(new Event(QuickContacts.ADD));
		}
		
		private function createCircle():void
		{
			addCircle(596);
			//TweenMax.delayedCall(1, addCircle, [315]);
			//TweenMax.delayedCall(2, addCircle, [410]);
			
			_world.addTimeStepSequence({time:_world.totalTimeSteps + 150, callback:createCircle});
		}	
		
		private function addCircle(xp : Number):void 
		{
			var qo : QuickObject = _world.addCircle( { radius:15, x:xp, y:35, skin:FireBall } );
			_balls[qo.shape] = qo;
		}
		
		private function destroyCircle(qo : QuickObject):void
		{
			if (_world.isRunning()) AnimationManager.destroyObjectSmoke(qo);
		}
	}
}