package com.caichoi
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	
	import flash.geom.Point;
	
	public class EnemyDispatcher extends TickedComponent
	{
		// Number of seconds to dispatch next enemy.
		private static const DISPATCH_INTERVAL:Number = 6;
		private static const BATCH_SIZE:uint = 3;
		
		public function EnemyDispatcher()
		{
			super();
		}
		
		private var timeSinceLastDispatch:Number = DISPATCH_INTERVAL;
		
		override public function onTick(deltaTime:Number):void
		{
			super.onTick(deltaTime);
			timeSinceLastDispatch += deltaTime;
			if(timeSinceLastDispatch >= DISPATCH_INTERVAL)
			{
				timeSinceLastDispatch = 0;
				for(var i:int = 0; i < BATCH_SIZE; i++)
					dispatch();
			}
		}
		
		// Dispatch an enemy fighters.
		private function dispatch():void
		{
			const enemyEntity:IEntity = PBE.templateManager.instantiateEntity("enemy");
			const enemySpatial:SimpleSpatialComponent = enemyEntity.lookupComponentByName("spatial") as SimpleSpatialComponent;
			
			const size:uint = Math.random() * 30 + 30;
			const posX:int = Math.random() * (Main.WIDTH - 2 * size) - (Main.BOUND_X - size);
			const posY:int = -(Main.BOUND_Y + size);
			const velY:int = Math.random() * 50 + 50;
			enemySpatial.position = new Point(posX, posY); 
			enemySpatial.size = new Point(size, size);
			enemySpatial.velocity = new Point(0, velY);
			//enemySpatial.rotation = 180;
			(enemyEntity.lookupComponentByName("health") as EnemyHealth).health = size / 10;
		}
		
	}
}