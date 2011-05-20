package com.caichoi
{
	import com.pblabs.animation.AnimatorComponent;
	import com.pblabs.engine.entity.EntityComponent;
	
	public class EnemyHealth extends EntityComponent
	{
		public var health:uint = 5;
		
		public function EnemyHealth()
		{
			super();
		}
		
		public function hit():void
		{
			health--;
			if(health <= 0)
			{
				owner.destroy();
			}
			else
			{
				const animation:AnimatorComponent = owner.lookupComponentByName("spriteAnimations") as AnimatorComponent;
				animation.play("hit");
			}
		}
	}
}