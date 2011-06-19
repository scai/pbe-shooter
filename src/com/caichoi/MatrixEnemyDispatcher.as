package com.caichoi
{
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	import com.pblabs.engine.PBE;
	import flash.geom.Point;

	public class MatrixEnemyDispatcher
	{
		public function MatrixEnemyDispatcher()
		{
		}
		
		public function dispatch():void
		{
			// create enemies
			const colSpacing:uint = 10;
			const rowSpacing:uint = 20;
			var enemyScale:uint = 30;
			var yAxis:int = 0; 
			for(var row:uint = 0; row < 4; row++)
			{
				const enemySpan:uint = enemyScale + colSpacing;
				const countPerRow:uint = Main.WIDTH / enemySpan;
				const leftMargin:uint = enemySpan * countPerRow / 2;
				for(var col:uint = 0; col < countPerRow; col++)
				{
					const enemyEntity:IEntity = PBE.templateManager.instantiateEntity("enemy");
					const enemySpatial:SimpleSpatialComponent = enemyEntity.lookupComponentByName("spatial") as SimpleSpatialComponent;
					const xAxis:int = col * enemySpan - leftMargin + enemySpan / 2;
					enemySpatial.position = new Point(xAxis, yAxis); 
					enemySpatial.size = new Point(enemyScale, enemyScale);
					(enemyEntity.lookupComponentByName("health") as EnemyHealth).health = (row + 1) * 2;
				}
				yAxis -= enemySpan + rowSpacing;
				enemyScale *= 1.5;
			}
		}
	}
}