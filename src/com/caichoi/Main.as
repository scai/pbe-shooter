package com.caichoi
{
	import com.pblabs.animation.Animator;
	import com.pblabs.animation.AnimatorComponent;
	import com.pblabs.animation.AnimatorType;
	import com.pblabs.engine.*;
	import com.pblabs.engine.core.LevelEvent;
	import com.pblabs.engine.core.TemplateEvent;
	import com.pblabs.engine.core.TemplateManager;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.rendering2D.*;
	import com.pblabs.rendering2D.spritesheet.*;
	import com.pblabs.rendering2D.ui.SceneView;
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	
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
			PBE.registerType(SpriteSheetRenderer);
			PBE.registerType(CellCountDivider);
			PBE.registerType(Animator);
			PBE.registerType(AnimatorType);
			PBE.registerType(AnimatorComponent);
			PBE.registerType(EnemyHealth);
			PBE.registerType(EnemyController);
			PBE.registerType(EnemyDispatcher);
			PBE.registerType(ScrollingBitmapRenderer);
			
			PBE.startup(this);
			PBE.addResources(new Resources());
			PBE.screenManager.registerScreen("game", new GameScreen());
			PBE.screenManager.goto("game");
			
			PBE.levelManager.addFileReference(0, "assets/level.xml");
			PBE.levelManager.addGroupReference(0, "main");
			PBE.levelManager.addEventListener(LevelEvent.LEVEL_LOADED_EVENT, loadedHandler);
			PBE.levelManager.start();
			PBE.levelManager.loadLevel(0);
		}
		
		private function loadedHandler(event:Event):void
		{
			PBE.levelManager.removeEventListener(LevelEvent.LEVEL_LOADED_EVENT, loadedHandler);
			setupLevel();
		}
		
		private function setupLevel():void
		{
			// dispatch enemies
		}
		
	}
}