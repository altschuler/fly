package utils 
{
	/**
	 * ...
	 * @author Simon Altschuler
	 */
	public class ArrayUtils
	{
		
		static public function min(arr : Array, prop : String = null):*
		{
			var min : * ;
			var i:int;
			if (prop && arr.length > 0)
			{
				trace(arr[0]);
				min = arr[0][prop];
				for (i = 1; i < arr.length; i++) 
				{
					if (arr[i][prop] < min) min = arr[i][prop]; 
				}
			}
			else
			{
				min = arr[0];
				for (i = 1; i < arr.length; i++) 
				{
					if (arr[i] < min) min = arr[i]; 
				}
			}
			
			return min;
		}
		
		static public function max(arr : Array, prop : String = null):*
		{
			var i:int;
			var max : * ;
			if (prop)
			{
				max = arr[0][prop];
				for (i = 1; i < arr.length; i++) 
				{
					if (arr[i][prop] > max) max = arr[i][prop]; 
				}
			}
			else
			{
				max = arr[0];
				for (i = 1; i < arr.length; i++) 
				{
					if (arr[i] > max) max = arr[i]; 
				}
			}
			
			return max;
		}
		
		static public function traceArrayProperty(arr:Array, ...args):void 
		{		
			for (var i:int = 0; i < arr.length; i++) 
			{
				var s : String = i + ".";
				for (var j:int = 0; j < args.length; j++) 
				{
					s += "\t"+args[j] + ": " + arr[i][args[j]];
				}
				trace(s);
			}
		}
		
		static public function contains(arr:Array, value : *):Boolean 
		{
			for each(var e : * in arr)
			{
				if (e == value) return true;
			}
			
			return false;
		}
		
	}

}