package com.caichoi
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.debug.Logger;
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
		}
		
		private function imageLoadFailedHandler(imageResource:ImageResource):void
		{
			Logger.print(this, "Failed to load image '" + imageResource.filename + "'");
		}
	}
}