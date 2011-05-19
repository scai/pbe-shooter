package com.caichoi
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.core.ObjectType;
	import com.pblabs.rendering2D.SimpleShapeRenderer;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	
	/**
	 * Bullet controller.
	 */
	public class BulletController extends TickedComponent
	{
		// sibling components
		public var spatial:SimpleSpatialComponent;
		public var render:SimpleShapeRenderer;
		
		// visual
		private var alphaDelta:Number = 0;
		
		// state
		private var _active:Boolean = false;
		
		public function BulletController()
		{
			super();
		}
		
		public function set active(value:Boolean):void
		{
			_active = value;
			
			spatial.registerForTicks = value;
			registerForTicks = value;
			render.alpha = value ? 1 : 0;
		}
		
		override public function onTick(time:Number):void
		{
			// deactivate if not visible
			if(spatial.y < - (Main.BOUND_Y + 100))  // 让子弹飞一会儿
			{
				active = false;
				PlayerController.bulletPool.push(this.owner);
				return;
			}
			
			var results:Array = [];
			const hit:Boolean = spatial.spatialManager.queryRectangle(spatial.worldExtents, ObjectType.wildcard, results);
			if(hit)
			{
				for(var v:Object in results)
				{
					trace(v);
				}
			}
			/*
			// blink
			render.alpha += alphaDelta;
			if(render.alpha >= 1)
				alphaDelta = -0.1;
			else if(render.alpha <= 0.3)
				alphaDelta = 0.1;
			*/
		}
	}
}