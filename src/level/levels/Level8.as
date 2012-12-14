package level.levels 
{
	import Box2D.Common.Math.b2Vec2;
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickObject;
	import com.greensock.TweenMax;
	import events.LevelEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import game.animation.AnimationManager;
	import game.hero.Hero;
	import level.elements.Cannon;
	import level.elements.FireBall;
	import level.elements.LevelElement;
	import level.elements.MetalBox;
	import level.elements.Platform1;
	import level.elements.Portal;
	import level.elements.RoundHandle;
	import level.elements.WoodBox;
	import level.elements.WoodBoxLong;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Level8 extends Level
	{
		private var _balls:Dictionary;		
		private var g1_2:QuickObject;
		private var g2_2:QuickObject;
		
		public function Level8() 
		{
			_targetPosition = new Point(580, 400);
			_startPosition = new Point(50, 400);
			
			_name = "Shower";
			_ID = 7;
			
			_balls = new Dictionary(true);
			
			_map =  [
					[101, 395, 16, 124, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1],
					[532, 395, 16, 124, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
				];
		}
		
		override public function build(world:QuickBox2D, hero : Hero):void 
		{
			super.build(world,  hero);
			
			//var g1_1 : QuickObject = world.addBox( { x:55, y:63, width:70, height:53, angle:0.209, density:0, groupIndex:-3, skin:Cannon } );
			g1_2 = world.addBox( { x:55, y:50, width:70, height:53, angle:0, density:0, groupIndex:-3, skin:Cannon } );
			//var g1_3 : QuickObject = world.addBox( { x:55, y:184, width:70, height:53, angle: -0.209, density:0, groupIndex:-3, skin:Cannon } );
			
			//var g2_1_skin : LevelElement = new Cannon();
			var g2_2_skin : LevelElement = new Cannon();
			//var g2_3_skin : LevelElement = new Cannon();
			
			//g2_1_skin.scaleX =
			//g2_3_skin.scaleX =
			g2_2_skin.scaleX = -1;
			
			//var g2_1 : QuickObject = world.addBox( { x:592, y:63, width:70, height:53, angle:-0.209, density:0, groupIndex:-3, skin:g2_1_skin } );
			g2_2 = world.addBox( { x:592, y:50, width:70, height:53, angle:0, density:0, groupIndex:-3, skin:g2_2_skin } );
			//var g2_3 : QuickObject = world.addBox( { x:592, y:184, width:70, height:53, angle: 0.209, density:0, groupIndex:-3, skin:g2_3_skin} );
			
			world.addTimeStepSequence({time:1, callback:createCircles});
		}
		
		override protected function contactAdd(e:Event):void 
		{
			super.contactAdd(e);
			
			if (_contacts.inCurrentContact(_floor))
			{			
				var le1 : LevelElement = _contacts.currentPoint.shape1.m_body.m_userData;
				var le2 : LevelElement = _contacts.currentPoint.shape2.m_body.m_userData;

				if (le1.type == LevelElement.BALL)
				{
					destroyCircle(_balls[_contacts.currentPoint.shape1]);
				}
				else if (le2.type == LevelElement.BALL)
				{
					destroyCircle(_balls[_contacts.currentPoint.shape2]);
				}
			}
		}
		
		private function createCircles():void
		{
			var spd : Number = 2;
			//addCircle(84, 56, new b2Vec2(4/3));
			//_world.addTimeStepSequence({time:_world.totalTimeSteps + 10, callback:addCircle, args:[82, 110, new b2Vec2(3/3)]});
			_world.addTimeStepSequence({time:_world.totalTimeSteps + 1, callback:addCircle, args:[g1_2.userData, new b2Vec2(spd * Math.cos(g1_2.angle), spd * Math.sin(g1_2.angle))]});
			//_world.addTimeStepSequence({time:_world.totalTimeSteps + 20, callback:addCircle, args:[76, 153, new b2Vec2(2/3)]});
			//
			//_world.addTimeStepSequence({time:_world.totalTimeSteps + 30, callback:addCircle, args:[563, 56, new b2Vec2(-4/3)]});
			//_world.addTimeStepSequence({time:_world.totalTimeSteps + 40, callback:addCircle, args:[565, 110, new b2Vec2(-3/3)]});
			_world.addTimeStepSequence({time:_world.totalTimeSteps + 11, callback:addCircle, args:[g2_2.userData, new b2Vec2(-spd * Math.cos(g2_2.angle), -spd * Math.sin(g2_2.angle))]});
			//_world.addTimeStepSequence({time:_world.totalTimeSteps + 50, callback:addCircle, args:[571, 153, new b2Vec2(-2/3)]});
			//
			_world.addTimeStepSequence({time:_world.totalTimeSteps + 21, callback:createCircles});
		}
		
		override protected function step(e:Event):void 
		{
			super.step(e);
			
			g1_2.angle = .3 + Math.sin(_world.totalTimeSteps/100) * .7;
			g2_2.angle = .3 + Math.sin(_world.totalTimeSteps/100) * .7;
		}
		
		private function addCircle(cannon : Cannon, impulse:b2Vec2):void 
		{
			var p : Point = cannon.localToGlobal(new Point(cannon.tip.x, cannon.tip.y));
			trace(p);
			var qo : QuickObject = _world.addCircle( { radius:7, x:p.x, y:p.y, groupIndex:-3, skin:FireBall } );
			qo.body.ApplyImpulse(impulse, qo.body.GetPosition());
			_balls[qo.shape] = qo;
			
			var s : Sprite = qo.body.m_userData as Sprite;
			s.parent.setChildIndex(s, 0);
		}
		
		private function destroyCircle(qo : QuickObject):void
		{
			if (_world.isRunning()) AnimationManager.destroyObjectSmoke(qo);
		}
	}

}