package game.animation 
{
	import com.actionsnippet.qbox.QuickObject;
	import com.greensock.events.TweenEvent;
	import com.greensock.TimelineMax;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Animation extends MovieClip
	{
		protected var _timeline : TimelineMax;
		protected var _qo : QuickObject;
		
		public function Animation(qo : QuickObject) 
		{
			_qo = qo;
		}
		
		public function playAnimation(removeAtComplete:Boolean = true):void
		{
			//Destroys the ANIMATION, not the QO
			_timeline.addEventListener(TweenEvent.COMPLETE, complete);
			_timeline.play();
		}
		
		protected function destroyQO():void 
		{
			//remove userData manually so that it doesn't get left when stopping the world
			if (_qo.body.GetUserData() is DisplayObject)
				_qo.body.GetUserData().parent.removeChild(_qo.body.GetUserData());
			_qo.destroy();
		}
		
		private function complete(e:TweenEvent):void 
		{
			if (parent) parent.removeChild(this);
		}
		
		protected function init():void 
		{
			
		}
		
		public function pauseAnimation():void
		{
			_timeline.pause();
		}
		
		public function resumeAnimation():void
		{
			_timeline.resume();
		}
	}

}