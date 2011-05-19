package com.caichoi
{
	import com.pblabs.engine.*;
	import com.pblabs.engine.core.LevelEvent;
	import com.pblabs.engine.core.TemplateManager;
	import com.pblabs.rendering2D.*;
	import com.pblabs.rendering2D.spritesheet.*;
	import com.pblabs.rendering2D.ui.SceneView;
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width="400", height="600", frameRate="60", backgroundColor="0x000000")]
	public class Main extends Sprite
	{
		public static const WIDTH:uint = 400;
		public static const HEIGHT:uint = 600;
		public static const BOUND_X:uint = Main.WIDTH / 2;
		public static const BOUND_Y:uint = Main.HEIGHT / 2;
		
		/**
		 * Game entry point.
		 */
		public function Main()
		{
			super();
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			PBE.registerType(DisplayObjectRenderer);
			PBE.registerType(DisplayObjectScene);
			PBE.registerType(Interpolated2DMoverComponent);
			PBE.registerType(SimpleSpatialComponent);
			PBE.registerType(SpriteSheetComponent);
			PBE.registerType(SpriteRenderer);
			PBE.registerType(SimpleShapeRenderer);
			PBE.registerType(KeyboardInput);
			PBE.registerType(PlayerController);
			PBE.registerType(BulletController);
			
			PBE.startup(this);
			PBE.addResources(new Resources());
			PBE.screenManager.registerScreen("game", new GameScreen());
			PBE.screenManager.goto("game");
			
			PBE.levelManager.start();
			PBE.levelManager.addFileReference(0, "assets/level.xml");
			PBE.levelManager.addGroupReference(0, "main");
			PBE.levelManager.loadLevel(0);
			PBE.levelManager.addEventListener("LEVEL_LOADED_EVENT", loadedHandler);
		}
		
		private function loadedHandler(event:Event):void
		{
			PBE.levelManager.removeEventListener("LEVEL_LOADED_EVENT", loadedHandler);
		}
		
	}
}