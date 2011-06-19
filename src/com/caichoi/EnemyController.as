package com.caichoi
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	
	import flash.geom.Point;
	
	public class EnemyController extends TickedComponent
	{
		
		public function EnemyController()
		{
			super();
		}
		
		private var spatial:SimpleSpatialComponent;
		private var playerSpatial:SimpleSpatialComponent;
		
		override public function onTick(deltaTime:Number):void
		{
			super.onTick(deltaTime);
			if(spatial.y >= 0 && spatial.velocity.x == 0)
			{
				spatial.velocity.x = (spatial.position.x > 0 ? -1 : 1) * Math.abs(spatial.velocity.y);
			}
		}
		
		override public function reset():void
		{
			super.reset();
			spatial = owner.lookupComponentByName("spatial") as SimpleSpatialComponent;
			playerSpatial = PBE.lookupEntity("player").lookupComponentByName("spatial") as SimpleSpatialComponent;
		}
		
	}
}