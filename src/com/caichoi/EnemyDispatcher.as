package com.caichoi
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	
	import flash.geom.Point;
	
	public class EnemyDispatcher extends TickedComponent
	{
		private static const DISPATCH_INTERVAL:Number = 1.2; // 3 seconds
		
		public function EnemyDispatcher()
		{
			super();
		}
		
		private var timeSinceLastDispatch:Number = 0;
		
		override public function onTick(deltaTime:Number):void
		{
			super.onTick(deltaTime);
			timeSinceLastDispatch += deltaTime;
			if(timeSinceLastDispatch >= DISPATCH_INTERVAL)
			{
				timeSinceLastDispatch = 0;
				dispatch();
			}
		}
		
		// Dispatch an enemy fighters.
		private function dispatch():void
		{
			const enemyEntity:IEntity = PBE.templateManager.instantiateEntity("enemy");
			const enemySpatial:SimpleSpatialComponent = enemyEntity.lookupComponentByName("spatial") as SimpleSpatialComponent;
			
			const size:uint = Math.random() * 40 + 40;
			const posX:int = Math.random() * (Main.WIDTH - 2 * size) - (Main.BOUND_X - size);
			const posY:int = -(Main.BOUND_Y + size);
			const velY:int = Math.random() * 50 + 50;
			enemySpatial.position = new Point(posX, posY); 
			enemySpatial.size = new Point(size, size);
			enemySpatial.velocity = new Point(0, velY);
			enemySpatial.rotation = 180;
			(enemyEntity.lookupComponentByName("health") as EnemyHealth).health = size / 10;
		}
		
	}
}