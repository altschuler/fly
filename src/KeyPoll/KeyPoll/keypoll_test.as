/**
* KeyPoll Test
* 
* If you are testing this directly from the Flash IDE, be sure
* to "Disable Keyboard Shortcuts" from the Control drop-down in the Flash Player.
* 
* @author Richard Davey / http://www.photonstorm.com
* @version 1.0 - 11th April 2008
*/

package  
{
	import bigroom.input.KeyPoll;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class keypoll_test extends Sprite
	{
		private var status:TextField;
		private var debug:TextField;
		private var keyboard:KeyPoll;
		
		public function keypoll_test():void
		{
			trace("KeyPoll Test is alive");
			
			//	Creates the KeyPoll object and tells it to listen to the stage for keyboard events
			keyboard = new KeyPoll(stage);
			
			//	A TextField that will display the key/s pressed
			debug = new TextField;
			debug.defaultTextFormat = new TextFormat(null, 14, 0xffffff, true);
			debug.autoSize = TextFieldAutoSize.LEFT;
			debug.multiline = true;
			debug.x = 16;
			debug.y = 64;
			
			//	A TextField that will display if the SWF window has focus or not (no focus, no keyboard events trigger!)
			status = new TextField;
			status.defaultTextFormat = new TextFormat(null, 14, 0xffff00, true);
			status.autoSize = TextFieldAutoSize.LEFT;
			status.x = 16;
			status.y = 16;

			//	Add them both to the stage
			addChild(debug);
			addChild(status);
			
			//	Create event listens for key presses and stage focus/loss
			addEventListener(Event.ENTER_FRAME, keyCheck, false, 0, true);
			addEventListener(Event.ACTIVATE, statusOn, false, 0, true );
			addEventListener(Event.DEACTIVATE, statusOff, false, 0, true );
		}
		
		private function keyCheck(event:Event):void
		{
			//	Returns whatever the most recent key held down was
			debug.text = "KeyCode currently down: " + keyboard.keyCode.toString();
			
			//	Test 1
			//	This code tests for just the A key being pressed on its own
			if (keyboard.isDown(KeyPoll.A))
			{
				debug.appendText("\n[+] the A key is pressed");
			}
			
			//	Test 2
			//	This code tests for the B key and the SHIFT key being held at the same time
			if (keyboard.isDown(KeyPoll.B, KeyPoll.SHIFT))
			{
				debug.appendText("\n[+] the B+SHIFT keys are pressed");
			}
			
			//	Test 3
			//	Tests code tests for the C key, the SHIFT key and the UP key all at the same time!
			if (keyboard.isDown(KeyPoll.C, KeyPoll.SHIFT, KeyPoll.UP))
			{
				debug.appendText("\n[+] the C+SHIFT+UP keys are pressed");
			}
			
			//	If you are ambidextrous enough you can actually fire-off all 3 tests at once
			//	by holding down A, B, C, SHIFT and UP!
		}
		
		private function statusOn(event:Event):void
		{
			status.text = "SWF has focus";
		}
		
		private function statusOff(event:Event):void
		{
			status.text = "SWF lost focus";
		}
	}
}
