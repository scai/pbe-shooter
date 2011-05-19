package com.caichoi
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.InputMap;
	import com.pblabs.engine.debug.Logger;
	import com.pblabs.engine.entity.EntityComponent;
	
	/**
	 * Handles keyboard input.
	 */
	public class KeyboardInput extends EntityComponent
	{
		public function KeyboardInput()
		{
			super();
		}
		
		private var _inputMap:InputMap;
		
		// Key state. keydown=1; keyup=0.
		public var up:int;
		public var down:int;
		public var left:int;
		public var right:int;
		public var shoot:int;
		
		public function get inputMap():InputMap
		{
			return _inputMap;
		}
		
		public function set inputMap(map:InputMap):void
		{
			_inputMap = map;
			if(_inputMap != null)
			{
				_inputMap.mapActionToHandler("up", upHandler);
				_inputMap.mapActionToHandler("down", downHandler);
				_inputMap.mapActionToHandler("left", leftHandler);
				_inputMap.mapActionToHandler("right", rightHandler);
				_inputMap.mapActionToHandler("shoot", shootHandler);
			}
		}
		
		private function upHandler(value:Number):void
		{
			up = value;
		}
		private function downHandler(value:Number):void
		{
			down = value;
		}
		
		private function leftHandler(value:Number):void
		{
			left = value;
		}
		
		private function rightHandler(value:Number):void
		{
			right = value;
		}
		
		private function shootHandler(value:Number):void
		{
			shoot = value;
		}
	}
}