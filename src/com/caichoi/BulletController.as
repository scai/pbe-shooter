package com.caichoi
{
	import com.pblabs.animation.AnimatorComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.core.ObjectType;
	import com.pblabs.engine.entity.IEntity;
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
		
		// collision
		private const ENEMY_OBJECT:ObjectType = new ObjectType("enemy");
		
		public function BulletController()
		{
			super();
		}
		
		public function set active(value:Boolean):void
		{
			_active = value;
			spatial.registerForTicks = value;
			this.registerForTicks = value;
			if(value)
			{
				spatial.size.x = 10;
			}
			else
			{
				spatial.size.x = 0;
				PlayerController.bulletPool.push(this.owner);
			}
		}
		
		override public function onTick(time:Number):void
		{
			if(!_active)
				return;
			
			// deactivate if not visible
			if(spatial.y < -Main.BOUND_Y)  // 让子弹飞一会儿
			{
				active = false;
				return;
			}
			
			// collision detection
			var results:Array = [];
			if(spatial.spatialManager.queryRectangle(spatial.worldExtents, ENEMY_OBJECT, results))
			{
				const enemySpatial:SimpleSpatialComponent = results[0] as SimpleSpatialComponent;
				const health:EnemyHealth = enemySpatial.owner.lookupComponentByName("health") as EnemyHealth;
				health.hit();
				active = false;
				return;
			}
		}
	}
}