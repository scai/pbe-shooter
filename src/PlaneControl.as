package 
{
	import Box2D.Common.Math.b2Math;
	
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.core.InputKey;
	import com.pblabs.engine.entity.PropertyReference;
	
	import flash.geom.Point;
	
	public class PlaneControl extends TickedComponent
	{
		public var positionReference:PropertyReference;
		private var sinceLastFire:Number = 0;
		
		private const ACCEL:Number = 3, 
			FRICTION:Number = 1, 
			MAX_SPEED:Number= 10;
		
		private var vel_x:Number = 0, 
			vel_y:Number = 0;
		
		internal var game:Game;
		
		public override function onTick(tickRate:Number):void
		{
			var position:Point = owner.getProperty(positionReference);
			
			if(PBE.isKeyDown(InputKey.RIGHT))
				vel_x += ACCEL;
			if(PBE.isKeyDown(InputKey.LEFT))
				vel_x -= ACCEL;
			if(PBE.isKeyDown(InputKey.UP))
				vel_y -= ACCEL;
			if(PBE.isKeyDown(InputKey.DOWN))
				vel_y += ACCEL;
			
			if(vel_x > 0)
				vel_x = b2Math.b2Clamp(vel_x - FRICTION, 0, MAX_SPEED);
			else
				vel_x = b2Math.b2Clamp(vel_x + FRICTION, - MAX_SPEED, 0);
			if(vel_y > 0)
				vel_y = b2Math.b2Clamp(vel_y - FRICTION, 0, MAX_SPEED);
			else
				vel_y = b2Math.b2Clamp(vel_y + FRICTION, - MAX_SPEED, 0);
			
			position.x = b2Math.b2Clamp(position.x + vel_x, -400, 400);
			position.y = b2Math.b2Clamp(position.y + vel_y, -300, 300);
			owner.setProperty(positionReference, position);
			
			sinceLastFire += tickRate;
			if(PBE.isKeyDown(InputKey.Z))
			{
				if(sinceLastFire > 0.1)
				{
					sinceLastFire = 0;
					for each (var b:Bullet in Game.bullets)
					{
						if(!b.active)
						{
							b.start(position);
							break;
						}
					}
				}
			}
		}
		
	}
}
