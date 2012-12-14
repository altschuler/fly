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
	public class TeleportAnimation extends Animation
	{
		public var cloud : MovieClip;
		
		public function TeleportAnimation(qo:QuickObject) 
		{
			super(qo);
			
			_timeline = new TimelineMax();
			_timeline.append(new TweenMax(cloud, .5, { alpha:0} ));
		}
		
	}

}