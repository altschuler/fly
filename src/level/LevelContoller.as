package level 
{
	import com.actionsnippet.qbox.QuickBox2D;
	import com.actionsnippet.qbox.QuickContacts;
	import com.greensock.TweenMax;
	import events.LevelEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import game.animation.AnimationManager;
	import game.hero.Hero;
	import level.elements.LevelElement;
	import level.levels.*
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class LevelContoller extends EventDispatcher
	{
		//static
		{
			_levels = [new Level1(), new Level2(), new Level3(), new Level4(), new Level5(), new Level6(), new Level7(), new Level8(), new Level9()];
		}
		//TODO move hero to gamecontroller
		private var _hero : Hero;
		static private var _levels : Array;
		private var _currentLevel:Level;
		private var _currentWorld:QuickBox2D;
		
		public function LevelContoller() 
		{
			_hero = new Hero();
		}
		
		public function buildLevel(index : uint, world : QuickBox2D):void
		{
			if (_currentLevel)
			{
				_currentLevel.removeEventListener(LevelEvent.LEVEL_FAILED, onLevelEvent);
				_currentLevel.removeEventListener(LevelEvent.LEVEL_FINISHED, onLevelEvent);
			}
			//TODO Performance difference?
			//var lvlClass : Class = _levels[index] as Class;
			//var lvl:Level = new lvlClass() as Level;
			var lvl : Level = _levels[index];
			lvl.build(world, _hero);
			
			lvl.addEventListener(LevelEvent.LEVEL_FAILED, onLevelEvent,false,0,true);
			lvl.addEventListener(LevelEvent.LEVEL_FINISHED, onLevelEvent, false, 0, true);
			
			_currentLevel = lvl;
			_currentWorld = world;
		}
		
		private function onLevelEvent(e:LevelEvent):void 
		{
			var le : LevelEvent = new LevelEvent(e.type, e.levelID, e.time);
			
			switch (le.type)
			{
				case LevelEvent.LEVEL_FAILED:
					_hero.enableControl = false;
					AnimationManager.detroyHeroFail(_hero.qo);
					break;
				case LevelEvent.LEVEL_FINISHED:
					_hero.enableControl = false;
					AnimationManager.detroyHeroWin(_hero.qo);
					break;
			}
			
			dispatchEvent(le);
		}
		
		public function runCurrentLevel():void
		{	
			_hero.enableControl = true;
		}
		
		static public function getLevelFromID(id : uint):Level
		{
			for each (var l : Level in _levels)
			{
				if (l.ID == id) return l;
			}
			
			return null;
		}
		
		static public function getLevels():Array
		{
			return _levels;
		}
		
		public function get currentLevel():Level { return _currentLevel; }
		
	}

}