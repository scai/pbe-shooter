package
{
	import com.pblabs.engine.*;
	import com.pblabs.engine.entity.*;
	import com.pblabs.rendering2D.*;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Enemy
	{
		internal var bullet:IEntity;
		internal var controller:BulletControl;
		internal var spatial:SimpleSpatialComponent;
		internal var active:Boolean = true;
		internal var render:SpriteRenderer;
		
		public function Enemy(name:String, pos:Point)
		{
			spatial = new SimpleSpatialComponent();
			spatial.position = pos;
			spatial.size = new Point(30, 30);
			spatial.spatialManager = PBE.spatialManager;
			
			bullet = allocateEntity();
			bullet.addComponent(spatial, "Spatial");
			
			render = new SpriteRenderer();
			render.fileName = "assets/enemy.png";
			render.scene = PBE.scene;
			render.layerIndex = 11;
			render.positionProperty = new PropertyReference("@Spatial.position");
			render.sizeProperty= new PropertyReference("@Spatial.size");
			bullet.addComponent(render, "Plane");
			
			//controller = new BulletControl();
			//controller.bullet = this;
			//bullet.addComponent(controller, "Controller");
			
			bullet.initialize(name);
		}
		
		public function hit():void
		{
			render.alpha -= 0.3;
			if(render.alpha <= 0.5)
			{
				render.layerIndex = 0;
				active = false;
			}
		}
	}
}