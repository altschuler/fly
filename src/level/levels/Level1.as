package level.levels 
{
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickContacts;
	import com.actionsnippet.qbox.QuickObject;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import game.animation.AnimationManager;
	import game.hero.Hero;
	import level.elements.LevelElement;
	import level.elements.MetalBall;
	import level.elements.Platform1;
	import level.elements.PlatformLong1;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Level1 extends Level
	{	
		private var _balls : Dictionary;
		
		public function Level1():void 
		{
			_balls = new Dictionary(true);
			_name = "Nuuk out";
			_ID = 0;
			
			_startPosition = new Point(50, 400);
			_targetPosition = new Point(584, 397);
			
			_map =  [
					[136, 200, 10, 100, -Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					,[40, 130, 10, 100, Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					,[136, 338, 10, 100, -Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					,[40, 268, 10, 100, Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					
					,[136+179, 130, 10, 100, -Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					,[40+179, 200, 10, 100, Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					,[136+179, 268, 10, 100, -Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					,[40 + 179, 338, 10, 100, Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					
					,[136+179+179, 200, 10, 100, -Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					,[40+179+179, 130, 10, 100, Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					,[136+179+179, 338, 10, 100, -Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					,[40 + 179+179, 268, 10, 100, Math.PI / 6, false, 'SQUARE' , 0.5, 0.5, 0.5, Platform1, -1]
					
					,[179, 255, 10, 370, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, PlatformLong1, -1]
					,[179 * 2, 190, 10, 370, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, PlatformLong1, -1]
					,[179 * 3, 255, 10, 370, Math.PI / 2, false, 'SQUARE' , 0.5, 0.5, 0.5, PlatformLong1, -1]
				];
		}
		
		override public function build(world:QuickBox2D, hero : Hero):void
		{
			super.build(world, hero);
			
			world.addTimeStepSequence({time:1, callback:createCircle});
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
		
		private function createCircle():void
		{
			addCircle(50);
			TweenMax.delayedCall(1, addCircle, [315]);
			TweenMax.delayedCall(2, addCircle, [410]);
			
			_world.addTimeStepSequence({time:_world.totalTimeSteps + 250, callback:createCircle});
		}	
		
		private function addCircle(xp : Number):void 
		{
			var qo : QuickObject = _world.addCircle( { radius:20, x:xp, y:50, skin:MetalBall } );
			_balls[qo.shape] = qo;
		}
		
		private function destroyCircle(qo : QuickObject):void
		{
			if (_world.isRunning()) AnimationManager.destroyObjectSmoke(qo);
		}
		
	}

}