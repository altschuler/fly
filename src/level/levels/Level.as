package level.levels 
{
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickContacts;
	import com.actionsnippet.qbox.QuickObject;
	import com.adobe.utils.ArrayUtil;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import events.LevelEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import game.animation.AnimationManager;
	import game.hero.Hero;
	import level.elements.Frame;
	import level.elements.LevelElement;
	import level.elements.Portal;
	import level.elements.Target;
	
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class Level extends EventDispatcher
	{
		protected var _targetPosition : Point;
		protected var _startPosition : Point;
		
		protected var _target : QuickObject;
		protected var _hero : Hero;
		
		protected var _contacts : QuickContacts;
		protected var _map : Array;
		protected var _world : QuickBox2D;
		
		protected var _floor  : QuickObject;
		
		protected var _name : String;
		protected var _ID : uint;
		protected var _tweens : Dictionary;
		
		protected var _portalBuffer : Array;
		protected var _bufferedActions:Array;
		
		public function build(world : QuickBox2D, hero : Hero):void 
		{
			_portalBuffer = new Array();
			_bufferedActions = new Array();
			_world = world;
			_hero = hero;
			_tweens = new Dictionary(true);
			
			if (_map) parseMap();
			buildCommons();
			hero.build(world, _startPosition);
			
			world.addEventListener(QuickBox2D.STEP, step)
			_contacts = world.addContactListener();
			_contacts.addEventListener(QuickContacts.ADD, contactAdd);
			_contacts.addEventListener(QuickContacts.REMOVE, contactRemove);
		}
		
		protected function step(e:Event):void 
		{
			for (var i:int = 0; i < _bufferedActions.length; i++) 
			{
				var f : Function = _bufferedActions[i].callback;
				var args : Array = _bufferedActions[i].args;
				switch(args.length)
				{
					case 0: f(); break;
					case 1: f(args[0]); break;
					case 2: f(args[0],args[1]); break;
					case 3: f(args[0],args[1],args[2]); break;
					case 4: f(args[0],args[1],args[2],args[3]); break;
					case 5: f(args[0],args[1],args[2],args[3],args[4]); break;
				}
				
				ArrayUtil.removeValueFromArray(_bufferedActions, _bufferedActions[i]);
			}
		}
		
		private function parseMap():void
		{
			//order: x , y , height, width, rotation, isDynamic, shape, friction,density,restitution,ID  & vertices 
			var i : uint;
			for (i = 0; i < _map.length; i++)
			{
				var element : Array = _map[i];
				switch (element[6])
				{
					case "SQUARE":
						_world.addBox( { x:element[0], y:element[1], width:element[3], height:element[2], angle:element[4], skin:element[10], density:int(element[5]), groupIndex:element[11] } );
						break;
					case "CIRCLE":
						_world.addCircle( { x:element[0], y:element[1], radius:element[3]/2, skin:element[10], angle:element[4], density:int(element[5]), groupIndex:element[11] } );
						break;
				}
			}
		}
		
		protected function createSegCircle(radius:Number, segs : uint, thickness:Number, params:Object, excludedSegs:Array = null):QuickObject
		{
			if (!excludedSegs) excludedSegs = [];
			
			var segLength : Number = (2 * Math.PI * radius) / segs;
			var angle : Number = 0;
			var segObjects : Array = [];
			var density : Number = params.density != null ? params.density : 1;
			var skin : * = params.segSkin ? params.skin : null;
			for (var i:int = 0; i < segs; i++) 
			{
				if (excludedSegs.indexOf(i) == -1)
				{
					var seg : QuickObject = _world.addBox( { skin:skin, width:segLength, height:thickness, angle:angle-Math.PI/2, x:Math.cos(angle) * (radius), y:Math.sin(angle) * (radius), density:density } );
					segObjects.push(seg);
				}
				angle += (2 * Math.PI) / segs;
			}
			if (params.segSkin) params.skin = null;
			params.objects = segObjects;
			return _world.addGroup( params );
		}
		
		protected function contactAdd(e:Event):void 
		{
			if (_contacts.inCurrentContact(_hero.qo))
			{
				//TODO check if this is a group object
				//if (_contacts.currentPoint.shape1.m_body.m_userData is LevelElement && _contacts.currentPoint.shape2.m_body.m_userData is LevelElement) return;
				
				var le1 : LevelElement = _contacts.currentPoint.shape1.m_body.m_userData;
				var le2 : LevelElement = _contacts.currentPoint.shape2.m_body.m_userData;
				
				if (le1.type == LevelElement.TARGET || le2.type == LevelElement.TARGET)// Level finished
				{
					dispatchEvent(new LevelEvent(LevelEvent.LEVEL_FINISHED, _ID));
				}
				else if (le1.deadly || le2.deadly)// Player dead
				{
					dispatchEvent(new LevelEvent(LevelEvent.LEVEL_FAILED, _ID));
				}
				
				//Portal handling
				var p : Portal;
				if (le1.type == LevelElement.PORTAL) 
					p = le1 as Portal;
				else if (le2.type == LevelElement.PORTAL) 
					p = le2 as Portal;
				
				if (p) 
				{
					if (!p.disabled) 
					{
						trace("Active portal hit: " + p.name);
						addActionToBuffer(moveQO, _hero.qo, p.destPoint, true)
					}
				}
			}
		}
	
		protected function contactRemove(e:Event):void 
		{
			var le1 : DisplayObject = _contacts.currentPoint.shape1.m_body.m_userData;
			var le2 : DisplayObject = _contacts.currentPoint.shape2.m_body.m_userData;
			
			if (le1 is Portal) trace("Contact removed: ", le1.name);
			if (le2 is Portal) trace("Contact removed: ", le2.name);
			
			for (var i:int = 0; i < _portalBuffer.length; i++) 
			{
				var p : Portal = _portalBuffer[i] as Portal;
				if (_contacts.inCurrentContact(p.qo)) 
				{
					//togglePortal(p, false);
					ArrayUtil.removeValueFromArray(_portalBuffer, p);
					//addActionToBuffer( togglePortal, p, false );
				}
				
			}
		}
		
		protected function addActionToBuffer(callback : Function, ...args):void 
		{	
			_bufferedActions.push({callback:callback, args:args == null ? [] : args});
		}
		
		private function moveQO(qo:QuickObject, loc:Point, teleport:Boolean = false):void
		{
			trace("Moving QO to ", loc);
			qo.x = loc.x;
			qo.y = loc.y;
			
			if (teleport)
			{
				AnimationManager.teleport(qo, loc);
			}
		}
		
		protected function buildCommons():void
		{
			_world.addBox( { width:640, height:10, x:320, y:5, skin:Frame, density:0, groupIndex:-1} );
			_floor = _world.addBox( { width:640, height:10, x:320, y:445, skin:Frame, density:0, groupIndex:-1} );
			_world.addBox( { width:10, height:450, x:5, y:225, skin:Frame, density:0, groupIndex:-1} );
			_world.addBox( { width:10, height:450, x:635, y:225, skin:Frame, density:0, groupIndex: -1 } );
			
			_target = _world.addCircle( { radius:15, x:_targetPosition.x, y:_targetPosition.y, skin:Target, density:0} );
		
		}
		
		public function pauseAnimations():void
		{
			for each (var t : TimelineMax in _tweens)
			{
				t.pause();
			}
		}
		
		public function resumeAnimations():void
		{
			for each (var t : TimelineMax in _tweens)
			{
				t.resume();
			}
		}
		
		public function get target():QuickObject { return _target; }
		
		public function get contacts():QuickContacts { return _contacts; }
		
		public function get name():String { return _name; }
		
		public function get ID():uint { return _ID; }
	}
	
}