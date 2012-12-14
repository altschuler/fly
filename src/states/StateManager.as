package states 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class StateManager
	{/*
		static private var _instance : StateManager;
		public static function gi():StateManager
		{
			return _instance ? _instance : _instance = new StateManager();
		}
		*/
		static private var _states : Object;
		static private var _currentState : State;
		static private var _stateContainer : Sprite;
		
		static public function init(stateContainer:Sprite):void
		{
			_states = new Object();
			_stateContainer = stateContainer;
		}
		
		static public function addState(state : State):void 
		{
			_states[state.id] = state;
			
			state.hide();
			_stateContainer.addChild(state);
		}
		
		static public function setState(id : String):void
		{
			if (_currentState) _currentState.hide();
			
			_currentState = _states[id];
			_currentState.show();
		}
		
	}

}