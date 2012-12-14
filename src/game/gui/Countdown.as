package game.gui 
{
	import com.greensock.easing.Quad;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import events.CountdownEvent;
	import events.LevelEvent;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import utils.GlobalStage;
	import utils.HotKeys;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Countdown extends Sprite
	{
		public var anim1 : Sprite;
		public var anim2 : Sprite;
		public var anim3 : Sprite;
		public var anim4 : Sprite;
		
		public var label : Sprite;
		
		private var _timeline : TimelineMax;
		
		public function Countdown() 
		{
			setupAnimation();
			resetAnimation();
		}
		
		private function setupAnimation():void
		{
			label.scaleX = label.scaleY = .7;
			label.alpha = 0;
			
			TweenMax.allTo([anim1, anim2, anim3, anim4], 0, { scale:2, alpha:0 } );
		
			_timeline = new TimelineMax();
			_timeline.insert(TweenMax.to(label, .2, { alpha:0, scale:.5, ease:Quad.easeOut } ));
			
			_timeline.insert(TweenMax.to(anim1, .2, { alpha:1, scaleX:1,scaleY:1, ease:Quad.easeIn } ));
			_timeline.insert(TweenMax.to(anim1, .2, { alpha:0, scaleX:.5,scaleY:.5, ease:Quad.easeOut } ), .8);
			
			_timeline.insert(TweenMax.to(anim2, .2, { alpha:1, scaleX:1,scaleY:1, ease:Quad.easeIn } ), 1);
			_timeline.insert(TweenMax.to(anim2, .2, { alpha:0, scaleX:.5,scaleY:.5, ease:Quad.easeOut } ), 1.8);
			
			_timeline.insert(TweenMax.to(anim3, .2, { alpha:1, scaleX:1,scaleY:1, ease:Quad.easeIn } ), 2);
			_timeline.insert(TweenMax.to(anim3, .2, { alpha:0, scaleX:.5,scaleY:.5, ease:Quad.easeOut } ), 2.8);
			
			_timeline.insert(TweenMax.to(anim4, .2, { alpha:1, scaleX:1,scaleY:1, ease:Quad.easeIn, onComplete: countdownEnd} ), 3);
			_timeline.insert(TweenMax.to(anim4, .2, { alpha:0, scaleX:.5,scaleY:.5, ease:Quad.easeOut, onComplete:resetAnimation } ), 3.5);
		}
		
		private function countdownEnd():void
		{
			dispatchEvent(new CountdownEvent(CountdownEvent.COUNTDOWN_END));
		}
		
		public function show():void
		{
			visible = true;
			TweenMax.to(label, .5, { scaleX:1, scaleY:1, alpha:1, ease:Quad.easeIn} );
			
			HotKeys.addKey(Keyboard.SPACE, animate);
		}
		
		public function set enabled (value : Boolean):void
		{
			if (value)
				HotKeys.addKey(Keyboard.SPACE, animate);
			else
				HotKeys.removeKey(Keyboard.SPACE);
		}
		
		private function animate():void
		{
			dispatchEvent(new CountdownEvent(CountdownEvent.COUNTDOWN_START));
			_timeline.play();
		}
		
		private function resetAnimation():void
		{	
			_timeline.gotoAndStop(0);
			visible = false;
		}
		
		public function pauseCountdown():void 
		{
			_timeline.pause();
		}
		
		public function resumeCountdown():void 
		{
			_timeline.resume();
		}
		
	}

}