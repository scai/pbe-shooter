package com.caichoi
{
	import com.pblabs.animation.AnimatorComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	
	import flash.geom.Point;
	
	public class EnemyHealth extends EntityComponent
	{
		public var health:uint = 5;
		private var _spatial:SimpleSpatialComponent;
		private function get spatial():SimpleSpatialComponent
		{
			if(_spatial == null)
				_spatial = owner.lookupComponentByName("spatial") as SimpleSpatialComponent;
			return _spatial;
		}
		
		private var _animation:AnimatorComponent;
		private function get animation():AnimatorComponent
		{
			if(_animation == null)
				_animation = owner.lookupComponentByName("spriteAnimations") as AnimatorComponent;
			return _animation;
		}
		
		public function EnemyHealth()
		{
			super();
		}
		
		public function hit():void
		{
			health--;
			if(health <= 0)
			{
				playExplosionAnimation();
				owner.destroy();
			}
			else
			{
				animation.play("hit");
			}
		}
		
		private function playExplosionAnimation():void
		{
			const explosionEntity:IEntity = PBE.templateManager.instantiateEntity("explosion");
			const explosionSpatial:SimpleSpatialComponent = explosionEntity.lookupComponentByName("spatial") as SimpleSpatialComponent;
			explosionSpatial.position = spatial.position;
			explosionSpatial.size = spatial.size;
		}
	}
}