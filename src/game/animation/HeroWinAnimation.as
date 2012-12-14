package game.animation 
{
	import com.actionsnippet.qbox.QuickObject;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class HeroWinAnimation extends Animation
	{
		public var smoke1 : MovieClip;
		public var smoke2 : MovieClip;
		public var smoke3 : MovieClip;
		
		public function HeroWinAnimation(qo : QuickObject) 
		{
			super(qo);
			
			_timeline = new TimelineMax();
			_timeline.append(new TweenMax(qo.userData, .5, {scale:0, onComplete:destroyQO } ));
			
		}

	}

}