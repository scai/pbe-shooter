package com.caichoi
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.debug.Logger;
	import com.pblabs.engine.resource.ImageResource;
	import com.pblabs.rendering2D.ui.SceneView;
	import com.pblabs.screens.BaseScreen;
	
	import flash.text.TextField;
	
	public class GameScreen extends BaseScreen
	{
		private var sceneView:SceneView = new SceneView();

		public function GameScreen()
		{
			super();
			sceneView.name = "sceneView";
			sceneView.width = Main.WIDTH;
			sceneView.height = Main.HEIGHT;
			addChild(sceneView);
			PBE.initializeScene(sceneView);
			
			PBE.resourceManager.load("assets/bg.png", 
				ImageResource, imageLoadSuccessHandler, imageLoadFailedHandler);
		}
		
		private function imageLoadSuccessHandler(imageResource:ImageResource):void
		{
			cacheAsBitmap = true;
			graphics.clear();
			graphics.beginBitmapFill(imageResource.image.bitmapData);
			graphics.drawRect(0, 0, sceneView.width, sceneView.height);
			graphics.endFill();
			
			
			var t:TextField = new TextField();
			t.textColor = 0xFFFFFF;
			t.text = "Shooter";
			PBE.mainStage.addChild(t);
		}
		
		private function imageLoadFailedHandler(imageResource:ImageResource):void
		{
			Logger.print(this, "Failed to load image '" + imageResource.filename + "'");
		}
	}
}