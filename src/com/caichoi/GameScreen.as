package com.caichoi
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.debug.Logger;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.resource.ImageResource;
	import com.pblabs.rendering2D.ui.PBLabel;
	import com.pblabs.rendering2D.ui.SceneView;
	import com.pblabs.screens.BaseScreen;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	
	public class GameScreen extends BaseScreen
	{
		internal const sceneView:SceneView = new SceneView();

		public function GameScreen()
		{
			super();
			sceneView.name = "sceneView";
			sceneView.width = Main.WIDTH;
			sceneView.height = Main.HEIGHT;
			addChild(sceneView);
			PBE.initializeScene(sceneView);
			PBE.resourceManager.load("assets/grey-tile-background.jpg", ImageResource, imageLoadSuccessHandler, imageLoadFailedHandler);
		}
		
		private function imageLoadSuccessHandler(imageResource:ImageResource):void
		{
			var bm:IEntity = PBE.allocateEntity();
			bm.initialize("bm_front");
			var sbr:ScrollingBitmapRenderer = new ScrollingBitmapRenderer(imageResource.image, Main.WIDTH, Main.HEIGHT);
			sbr.scene = PBE.scene;
			sbr.x = -1*(PBE.scene.sceneView.width/2);
			sbr.y = -1*(PBE.scene.sceneView.height/2);
			sbr.layerIndex = 0;
			sbr.scrollSpeed = new Point(0, -20);
			bm.addComponent(sbr, "render");
		}
		
		private function imageLoadFailedHandler(imageResource:ImageResource):void
		{
			Logger.print(this, "Failed to load image '" + imageResource.filename + "'");
		}
	}
}