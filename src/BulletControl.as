package
{
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	
	public class BulletControl extends TickedComponent
	{
		public var bullet:Bullet;
		
		public override function onTick(tickRate:Number):void
		{
			if(bullet.active)
			{
				if(bullet.spatial.y > -300) 
				{
					bullet.spatial.y -= 10;
					for each (var enemy:Enemy in Game.enemies)
					{
						if(enemy.active && hitTest(bullet, enemy))
						{
							bullet.hide();
							enemy.hit();
						}
					}
				}
				else
				{
					bullet.hide();
				}
							
			}
		}
		
		private static function hitTest(bullet:Bullet, enemy:Enemy):Boolean
		{
			return (bullet.spatial.x > enemy.spatial.x - 20 && 
				bullet.spatial.x < enemy.spatial.x + 20 &&
				bullet.spatial.y > enemy.spatial.y - 20 &&
				bullet.spatial.y < enemy.spatial.y + 20);
		}
	}
}