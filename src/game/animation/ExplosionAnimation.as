package game.animation 
{
	import com.actionsnippet.qbox.QuickObject;
	import com.greensock.easing.Linear;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class ExplosionAnimation extends Animation
	{
		private var _o : Object;
		
		public function ExplosionAnimation(qo : QuickObject) 
		{
			super(qo);
			gotoAndStop(0);
			_o = new Object();
			_o.pct = 0;
			_timeline = new TimelineMax();
			_timeline.insert(new TweenMax(_o, .5, { pct:1, onUpdate:updateFrame, onStart:destroyQO, ease:Linear.easeNone } ));
			init();
		}
		
		private function updateFrame():void
		{
			alpha = 1 - (_o.pct * .5); 
			this.gotoAndStop(int(_o.pct * totalFrames));
		}
		
		override protected function init():void 
		{
			gotoAndStop(0);
			_o.frame = 0;
		}
	}

}