package game.animation 
{
	import com.actionsnippet.qbox.QuickObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class AnimationManager
	{
		static private var _animations : Dictionary = new Dictionary(true);
		static private var _container:Sprite;
		
		public function AnimationManager() 
		{
			
		}
		
		static public function setContainer (container : Sprite):void
		{
			_container = container;
		}
		
		
		static public function destroyObjectSmoke(qo : QuickObject):void
		{
			var p: Point = new Point(qo.userData.x, qo.userData.y);
			var s: Point = new Point(qo.userData.width, qo.userData.height);
			
			var animation : Animation = new SmokeAnimation(qo);
			animation.x = p.x;
			animation.y = p.y;
			animation.width = s.x;
			animation.height = s.y;
			
			_container.addChild(animation);
			
			animation.playAnimation();
			
			_animations[qo] = animation;
		}
		
		static public function detroyHeroFail(qo : QuickObject):void
		{
			var p: Point = new Point(qo.userData.x, qo.userData.y);
			var s: Point = new Point(qo.userData.width, qo.userData.height);
			
			var animation : Animation = new ExplosionAnimation(qo);
			animation.x = p.x;
			animation.y = p.y;
			animation.width = s.x;
			animation.height = s.y;
			
			_container.addChild(animation);
			
			animation.playAnimation();
			
			_animations[qo] = animation;
		}
		
		//TODO animate into target
		static public function detroyHeroWin(qo : QuickObject):void
		{
			var p: Point = new Point(qo.userData.x, qo.userData.y);
			var s: Point = new Point(qo.userData.width, qo.userData.height);
			
			var animation : Animation = new HeroWinAnimation(qo);
			animation.x = p.x;
			animation.y = p.y;
			animation.width = s.x;
			animation.height = s.y;
			
			_container.addChild(animation);
			
			animation.playAnimation();
			
			_animations[qo] = animation;
		}
		
		static public function teleport(qo:QuickObject, destPoint:Point):void
		{			
			var p: Point = new Point(qo.userData.x, qo.userData.y);
			var s: Point = new Point(qo.userData.width, qo.userData.height);
			
			var animOrigin : Animation = new TeleportAnimation(qo);
			animOrigin.x = p.x;
			animOrigin.y = p.y;
			
			var animTarget : Animation = new TeleportAnimation(qo);
			animTarget.x = destPoint.x;
			animTarget.y = destPoint.y;
			
			_container.addChild(animOrigin);
			_container.addChild(animTarget);
			
			animOrigin.playAnimation();
			animTarget.playAnimation();
			
			_animations[qo] = [animOrigin, animTarget];

		}
		
		static public function pauseAll():void 
		{
			for each (var a : Animation in _animations)
			{
				a.pauseAnimation();
			}
		}
		
		static public function resumeAll():void 
		{
			for each (var a : Animation in _animations)
			{
				a.resumeAnimation();
			}
		}
	}

}