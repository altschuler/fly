package level.levels 
{
	import Box2D.Common.Math.b2Vec2;
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickObject;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import game.animation.AnimationManager;
	import game.hero.Hero;
	import level.elements.FireBall;
	import level.elements.LevelElement;
	import level.elements.Platform1;
	import level.elements.PlatformLong1;
	import level.elements.SensorTransparent;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Level2 extends Level
	{
		
		private var _balls : Dictionary;
		private var _sensor:QuickObject;
		
		public function Level2() 
		{
			_name = "The Funnel";
			_ID = 1;
			
			_startPosition = new Point(28, 414);
			_targetPosition = new Point(493, 334);
		
			_balls = new Dictionary(true);
			
			_map =  [
					[142,388,16,300,0,false,'SQUARE' , 0.5,0.5,0.5,PlatformLong1, -1],
					[200,188,16,250,Math.PI/4,false,'SQUARE' , 0.5,0.5,0.5,PlatformLong1, -1],
					[442,188,16,250,-Math.PI/4,false,'SQUARE' , 0.5,0.5,0.5,PlatformLong1, -1],
					[358,391,16,250,Math.PI/2,false,'SQUARE' , 0.5,0.5,0.5,PlatformLong1, -1],
					[545,179,16,355,-Math.PI/4,false,'SQUARE' , 0.5,0.5,0.5,PlatformLong1, -1],
					[283,332,16,131,Math.PI/2,false,'SQUARE' , 0.5,0.5,0.5,Platform1, -1],
					[423,347,16,103,Math.PI/2,false,'SQUARE' , 0.5,0.5,0.5,Platform1, -1],
					[565,347,16,103,Math.PI/2,false,'SQUARE' , 0.5,0.5,0.5,Platform1, -1],
					[494,393,16,158,0,false,'SQUARE' , 0.5,0.5,0.5,Platform1, -1]
					];
		}
		
		override public function build(world:QuickBox2D, hero : Hero):void
		{
			super.build(world, hero);
			
			_sensor = world.addBox( { x:357, y:350, width:130, height:50, isSensor:true, density:0, skin:SensorTransparent } );
			
			world.addTimeStepSequence({time:1, callback:createCircle});
		}
		
		override protected function contactAdd(e:Event):void 
		{
			super.contactAdd(e);
			
			var le1 : LevelElement = _contacts.currentPoint.shape1.m_body.m_userData;
			var le2 : LevelElement = _contacts.currentPoint.shape2.m_body.m_userData;

			if (le1.type == LevelElement.BALL)
				_contacts.currentPoint.shape1.m_restitution *= .8;
			
			if (le2.type == LevelElement.BALL)
				_contacts.currentPoint.shape2.m_restitution *= .8;
			
			if (_contacts.inCurrentContact(_sensor))
			{
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
		
		private function createCircle():void
		{
			addCircle(160, 1.2);
			addCircle(590);
			
			_world.addTimeStepSequence({time:_world.totalTimeSteps + 150, callback:createCircle});
		}	
		
		private function addCircle(xp : Number, r : Number = .5):void 
		{
			var qo : QuickObject = _world.addCircle( { radius:20, x:xp, y:30, groupIndex:-3, isBullet:true, restitution:r, skin:FireBall } );
			qo.body.ApplyImpulse(new b2Vec2(0, 15), qo.body.GetPosition());
			_balls[qo.shape] = qo;
		}
		
		private function destroyCircle(qo : QuickObject):void
		{
			if (_world.isRunning()) AnimationManager.destroyObjectSmoke(qo);
		}
	}
}