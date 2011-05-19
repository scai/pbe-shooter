package com.caichoi
{
	import Box2D.Common.Math.b2Math;
	
	import com.pblabs.animation.AnimatorComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.rendering2D.SimpleShapeRenderer;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	import com.pblabs.rendering2D.SpriteSheetRenderer;
	
	import flash.utils.flash_proxy;
	
	/**
	 * Controller for player pilot.
	 */
	public class PlayerController extends TickedComponent
	{
		public function PlayerController()
		{
			super();
		}
		
		// set in level manager
		public var keyboardInput:KeyboardInput;
		public var spatial:SimpleSpatialComponent;
		public var render:SpriteSheetRenderer;
		
		// motion physics
		private static const X:int = 30;
		private static const ACCEL:int = 3 * X;
		private static const FRICTION:int = 1 * X; 
		private static const MAX_SPEED:int= 10 * X;
		
		// bullets
		internal static var bulletPool:Array = new Array();
		private var bulletCount:uint = 0;
		private static const MAX_BULLETS:uint = 50;
		private var sinceLastShoot:Number = 0;
		public var shootInterval:Number;
		
		override public function onTick(time:Number):void
		{
			// update velocity
			spatial.velocity.x += (keyboardInput.right - keyboardInput.left) * ACCEL;
			spatial.velocity.y += (keyboardInput.down - keyboardInput.up) * ACCEL;
			
			// apply friction
			if(spatial.velocity.x > 0)
				spatial.velocity.x = b2Math.b2Clamp(spatial.velocity.x - FRICTION, 0, MAX_SPEED);
			else if(spatial.velocity.x < 0)
				spatial.velocity.x = b2Math.b2Clamp(spatial.velocity.x + FRICTION, - MAX_SPEED, 0);
			
			if(spatial.velocity.y > 0)
				spatial.velocity.y = b2Math.b2Clamp(spatial.velocity.y - FRICTION, 0, MAX_SPEED);
			else if(spatial.velocity.y < 0)
				spatial.velocity.y = b2Math.b2Clamp(spatial.velocity.y + FRICTION, - MAX_SPEED, 0);
			
			// avoid going off the border
			if(spatial.x <= -Main.BOUND_X && spatial.velocity.x < 0 || spatial.x >= Main.BOUND_X && spatial.velocity.x > 0)
				spatial.velocity.x = 0;
			else 
				spatial.velocity.x = spatial.velocity.x;
			
			if(spatial.y <= -Main.BOUND_Y && spatial.velocity.y < 0 || spatial.y >= Main.BOUND_Y && spatial.velocity.y > 0)
				spatial.velocity.y = 0;
			else
				spatial.velocity.y = spatial.velocity.y;
			
			// animation
			if(keyboardInput.left > 0)
				render.spriteIndex = 2;
			else if(keyboardInput.right > 0)
				render.spriteIndex = 1;
			else
				render.spriteIndex = 0;
			
			// fire
			if(sinceLastShoot < shootInterval)
			{
				sinceLastShoot += time;
			}
			else if(keyboardInput.shoot > 0 && bulletCount <= MAX_BULLETS)
			{
				sinceLastShoot = 0;
				var entity:IEntity;
				if(bulletPool.length > 0)
				{
					entity = bulletPool.pop();
				}
				else
				{
					entity = PBE.templateManager.instantiateEntity("bullet");
					bulletCount++;
				}
				const spatial:SimpleSpatialComponent = entity.lookupComponentByName("spatial") as SimpleSpatialComponent;
				spatial.position = this.spatial.position;
				const controller:BulletController = entity.lookupComponentByName("controller") as BulletController;
				controller.active = true;
			}
		}
	}
}