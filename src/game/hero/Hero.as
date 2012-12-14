package game.hero 
{
	import Box2D.Common.Math.b2Vec2;
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import uk.co.bigroom.input.KeyPoll;
	import utils.GlobalStage;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Hero
	{
		private var _skin : HeroGraphics;
		private var _qo : QuickObject;
		private var _ySensitivity : Number;
		private var _xSensitivity : Number;
		private var _world : QuickBox2D;
		
		public function Hero() 
		{
			_ySensitivity = .7;
			_xSensitivity = .3;
		}
		
		public function build(world : QuickBox2D, position : Point):QuickObject
		{
			_skin =  new HeroGraphics();
			_qo = world.addPoly( {verts:[_skin.verts], linearDamping:4, width:20, height:24, x:position.x, y:position.y, friction:.2, fixedRotation:true, skin:_skin, allowSleep:false} );
			_world = world;
			return _qo;
		}
		
		public function set enableControl ( value : Boolean) : void
		{
			if (value)
			{
				_world.addEventListener(QuickBox2D.STEP, checkKeys);
			}
			else
			{
				_world.removeEventListener(QuickBox2D.STEP, checkKeys);
			}
		}
		
		private function checkKeys(e:Event):void 
		{
			var ys : Number = _ySensitivity;
			var xs : Number = _xSensitivity;
			
			if (KeyPoll.isDown(Keyboard.SHIFT))
			{
				ys *= 2.5;
				xs *= 2.5;
			}
			
			if ((KeyPoll.isDown(Keyboard.UP)||KeyPoll.isDown(87)) && _qo.body.m_linearVelocity.y > -10)//87=w
				{
					_qo.body.m_linearVelocity.y -= ys;
					_skin.enableThrustDown = true;
				}
				else
				{
					_skin.enableThrustDown = false;
				}
			
			if (KeyPoll.isDown(Keyboard.DOWN) || KeyPoll.isDown(83))//83=s
			{
				_qo.body.m_linearVelocity.y += ys;
				_skin.enableThrustUp = true;
			}
			else
			{
				_skin.enableThrustUp = false;
			}
			
			if (KeyPoll.isDown(Keyboard.LEFT)||KeyPoll.isDown(65))//65=a
			{
				_qo.body.m_linearVelocity.x -= xs;
				_skin.enableThrustRight = true;
			}
			else
			{
				_skin.enableThrustRight = false;
			}
			
			if (KeyPoll.isDown(Keyboard.RIGHT) || KeyPoll.isDown(68))//68=d
			{
				_qo.body.m_linearVelocity.x += xs;
				_skin.enableThrustLeft = true;
			}
			else
			{
				_skin.enableThrustLeft = false;
			}
			
		}
		
		
		
		public function get qo():QuickObject { return _qo; }
		
		public function set qo(value:QuickObject):void 
		{
			_qo = value;
		}
		
	}

}