package
{
	import com.pblabs.engine.resource.ResourceBundle;

	public class MyResources extends ResourceBundle
	{
		[Embed(source="assets/bg.png")]
		public var resBg:Class;
		
		[Embed(source="assets/plane.png")]
		public var resPlane:Class;
		
		[Embed(source="assets/enemy.png")]
		public var resEnemy:Class;
	}
}