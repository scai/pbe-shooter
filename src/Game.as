package
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.LevelManager;
	import com.pblabs.engine.debug.Logger;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.engine.entity.allocateEntity;
	import com.pblabs.rendering2D.SimpleShapeRenderer;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	import com.pblabs.rendering2D.SpriteRenderer;
	import com.pblabs.rendering2D.ui.SceneView;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	[SWF(width="800", height="600", framerate="60", backgroundColor="#333333")]
	public class Game extends Sprite
	{
		internal static var bullets:Array = new Array();
		internal static var enemies:Array = new Array();
		
		public function Game()
		{
			PBE.startup(this);
			createScene();
			createBackground();
			createHero();
			createEnemies();
			for(var i:int = 0; i < 10; i++)
			{
				var name:String = "Bullet_" + i;
				bullets[i] = new Bullet(name);
			}
		}
		
		private function createScene():void
		{
			var sceneView:SceneView = new SceneView();
			sceneView.width = 800;
			sceneView.height = 600;;
			
			PBE.initializeScene(sceneView);
		}
		
		private function createEnemies():void
		{
			for(var i:int = 1; i <= 4; i++)
			{
				const y:int = 0 - i * 50;
				for(var j:int = 1; j <= 6; j++)
				{
					const x:int = j * 50;
					createEnemy(x, y);
					createEnemy(-x, y);
				}
			}
		}
		
		private function createEnemy(x:Number, y:Number):void
		{
			enemies.push(new Enemy("Enemey_" + enemies.length, new Point(x, y)));
		}
		
		private function createHero():void
		{
			var spatial:SimpleSpatialComponent = new SimpleSpatialComponent();
			spatial.position = new Point(0, 250);
			spatial.size = new Point(50,50);
			spatial.spatialManager = PBE.spatialManager;
			
			var entityPlane:IEntity = allocateEntity();
			entityPlane.addComponent(spatial, "Spatial");
			
			var plane:SpriteRenderer = new SpriteRenderer();
			plane.fileName = "assets/plane.png";
			plane.scene = PBE.scene;
			plane.layerIndex = 10;
			plane.positionProperty = new PropertyReference("@Spatial.position");
			plane.sizeProperty= new PropertyReference("@Spatial.size");
			entityPlane.addComponent(plane, "Plane");
			
			var controller:PlaneControl = new PlaneControl();
			controller.game = this;
			controller.positionReference = new PropertyReference("@Spatial.position");
			entityPlane.addComponent(controller, "Controller");
			
			entityPlane.initialize("Plane");
		}
		
		private function createBackground():void
		{
			var bg:IEntity = PBE.allocateEntity();
			var render:SpriteRenderer = new SpriteRenderer();
			render.fileName = "assets/bg.png";
			render.layerIndex = 1;
			render.scene = PBE.scene;
			bg.addComponent(render, "Render");
			bg.initialize("BG");
		}
	}
}