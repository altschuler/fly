﻿package com.actionsnippet.qbox{
	
	import flash.events.*;
	
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Dynamics.*;
	import Box2D.Common.Math.*;
	import Box2D.Common.*;
		
	/**
	QuickContacts is responsible for dispatching all events related to Box2D contacts You should not instantiate this class directly. Instead, use {@link com.actionsnippet.qbox.QuickBox2D#addContactListener()}. It's worth noting that this class subclasses Box2D's b2ContactListner.
	@author Zevan Rosser
	@version 1.1
	*/
	
	
	public class QuickContacts extends b2ContactListener implements IEventDispatcher{
		
		/**
		For use with the ADD event.
		*/
		public static const ADD:String = "add";
		/**
		For use with the REMOVE event.
		*/
		public static const REMOVE:String = "remove";
		/**
		For use with the PERSIST event.
		*/
		public static const PERSIST:String = "persist";
		/**
		For use with the RESULT event.
		*/
		public static const RESULT:String = "result";
		
		/**
		The newest/current b2ContactPoint. You may want to read this when an ADD, REMOVE or PERSIST event occurs.
		*/
		public var currentPoint:b2ContactPoint;
		/**
		The newest/current b2ContactResult. You may want to read this when a RESULT event occurs.
		*/
		public var currentResult:b2ContactResult;
		
		/**
		@exclude
		//The composed EventDispatcher instance, it is unlikely that you'll need to use this.
		*/
		public var dispatcher:EventDispatcher;
		
		private var contactAdd:Event = new Event("add");
		private var contactRemove:Event = new Event("remove");
		private var contactPersist:Event = new Event("persist");
		private var contactResult:Event = new Event("result");
		
		/**
		Main description text.
		@sends Event#ADD - dispatched whenever b2ContactPoint is created.
		@sends Event#REMOVE - dispatched whenever b2ContactPoint is removed.
		@sends Event#PERSIST - dispatched whenever b2ContactPoint persists.
		@sends Event#RESULT - dispatched whenever b2ContactPoint is solved.
		*/
		public function QuickContacts(){
			//contactEvent = new EventDispatcher();
			dispatcher = new EventDispatcher(this);
		}
		/**
		Checks to see if a QuickObject is part of the current ADD, REMOVE or PERSIST event. This should only be called within the listener function of any of these events.
		*/
		public function inCurrentContact(a:QuickObject):Boolean{
			var body1:b2Body = currentPoint.shape1.GetBody();
			var body2:b2Body = currentPoint.shape2.GetBody();
			var aBody:b2Body = a.body;
			if (aBody == body1){
				return true;
			}else if (aBody == body2){
				return true;
			}else{
				return false;
			}
		}
		/**
		Checks to see if QuickObjects <code>a</code> and <code>b</code> are part of the current ADD, REMOVE or PERSIST event. This should only be called within the listener function of any of these events. 
		*/
		public function isCurrentContact(a:QuickObject, b:QuickObject):Boolean{
			 
			var body1:b2Body = currentPoint.shape1.GetBody();
			var body2:b2Body = currentPoint.shape2.GetBody();
			var aBody:b2Body = a.body;
			var bBody:b2Body = b.body;
			if (body1 == aBody){
				if (body2 == bBody){
					return true
				}
			}else if (body1 == bBody){
				if (body2 == aBody){
					return true;
				}
			}
			return false
		}
		
		/**
		@exclude
		*/
		override public function Add(point:b2ContactPoint) : void{
			// trace("add");
			 //trace(point);
			 currentPoint = point;
			 dispatcher.dispatchEvent(contactAdd);
		};
	
		/**
		@exclude
		*/
		override public function Persist(point:b2ContactPoint) : void{
			 currentPoint = point;
			 dispatcher.dispatchEvent(contactPersist);
		};
	
		/**
		@exclude
		*/
		override public function Remove(point:b2ContactPoint) : void{
			//trace("remove");
			 currentPoint = point;
			 dispatcher.dispatchEvent(contactRemove);
		};
		
		/**
		@exclude
		*/
		override public function Result(point:b2ContactResult) : void{
			 currentResult = point;
			 dispatcher.dispatchEvent(contactResult);
		};
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{
        	dispatcher.addEventListener(type, listener, useCapture, priority);
    	}
           
		public function dispatchEvent(evt:Event):Boolean{
			return dispatcher.dispatchEvent(evt);
		}
    
		public function hasEventListener(type:String):Boolean{
			return dispatcher.hasEventListener(type);
		}
    
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
                   
		public function willTrigger(type:String):Boolean {
			return dispatcher.willTrigger(type);
		}
	}
}