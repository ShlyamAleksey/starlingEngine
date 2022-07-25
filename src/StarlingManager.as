package
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	import starling.core.Starling;
	import starling.textures.RenderTexture;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;

	public class StarlingManager
	{
		static public var stage:Stage;
		private var starling:Starling;
		private var viewRectangle:Rectangle;
		
		public function StarlingManager(flashStage:Stage)
		{
			Starling.handleLostContext = true;
			RenderTexture.optimizePersistentBuffers = false;
			Starling.multitouchEnabled = false;
			
			RenderTexture.optimizePersistentBuffers = false;
			stage = flashStage;
			
			this.viewRectangle = RectangleUtil.fit(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight),
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
				ScaleMode.SHOW_ALL, false, null);
			
			//this.viewRectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			this.starling = new Starling(appMain, flashStage, viewRectangle, null, 'auto', 'auto');
			this.starling.antiAliasing = 1;
			this.starling.start();
			this.starling.showStats = true;
				
			flashStage.addEventListener(flash.events.Event.RESIZE, onResize);
			
			this.onResize(null);
		}
		
		static public function definition(className:String):Class
		{
			return getDefinitionByName(className) as Class
		}
		
		protected function onResize(e:flash.events.Event):void
		{
			var viewRect:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			starling.viewPort = viewRect;
			
			starling.stage.stageWidth = stage.stageWidth;
			starling.stage.stageHeight = stage.stageHeight;	
		}
	}
}