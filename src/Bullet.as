package
{
	import com.pblabs.engine.*;
	import com.pblabs.engine.entity.*;
	import com.pblabs.rendering2D.*;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Bullet
	{
		internal var bullet:IEntity;
		internal var controller:BulletControl;
		internal var spatial:SimpleSpatialComponent;
		internal var render:SimpleShapeRenderer;
		internal var active:Boolean;
		
		public function Bullet(name:String)
		{
			spatial = new SimpleSpatialComponent();
			spatial.position = new Point(0, 0);
			spatial.size = new Point(4, 4);
			spatial.spatialManager = PBE.spatialManager;
			
			bullet = allocateEntity();
			bullet.addComponent(spatial, "Spatial");
			
			render = new SimpleShapeRenderer();
			render.fillColor = 0xFFFFFF;
			render.lineColor = 0xFFFFFF;
			render.isCircle = true;
			render.lineSize = 2;
			render.radius = 4;
			render.scene = PBE.scene;
			render.positionProperty = new PropertyReference("@Spatial.position");
			render.rotationProperty = new PropertyReference("@Spatial.rotation");
			hide();
			bullet.addComponent(render, "Render");
			
			controller = new BulletControl();
			controller.bullet = this;
			bullet.addComponent(controller, "Controller");
			
			bullet.initialize(name);
		}
		
		public function start(point:Point):void
		{
			spatial.position = point;
			render.layerIndex = 9;
			active = true;
		}
		
		public function hide():void
		{
			render.layerIndex = 0;
			active = false;
		}
		
	}
}