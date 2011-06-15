package com.caichoi
{
	import com.pblabs.animation.Animator;
	import com.pblabs.animation.AnimatorComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.rendering2D.IMobileSpatialObject2D;
	import com.pblabs.rendering2D.SimpleSpatialComponent;

	public class ExplosionFactory
	{
		public static const instance:ExplosionFactory = new ExplosionFactory();
		
		// Allocate 10 explosion animations.
		private static const BUFFER_SIZE:uint = 5;
		
		// Index of the next explosion animation to use.
		private var index:uint = 0;
		
		// pool
		private var pool:Array = new Array();
		
		public function ExplosionFactory()
		{
			for(var i:uint = 0; i < BUFFER_SIZE; i++)
			{
				pool.push(PBE.templateManager.instantiateEntity("explosion"));				
			}
		}
		
		public function explodeAt(spatial:IMobileSpatialObject2D):void
		{
			const entity:IEntity = pool[index] as IEntity;
			
			// position
			const animSpatial:SimpleSpatialComponent = entity.lookupComponentByType(SimpleSpatialComponent) as SimpleSpatialComponent;
			animSpatial.position = spatial.position;
			animSpatial.size = spatial.size;
			
			// play animation
			const animator:AnimatorComponent = entity.lookupComponentByType(AnimatorComponent) as AnimatorComponent;
			animator.play("explode");
			
			// advance index
			index = (index + 1) % BUFFER_SIZE;
		}
	}
}