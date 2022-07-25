package display
{
	import Assets.Content;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	dynamic public class SimpleSprite extends Sprite
	{	
		private var __assets:AssetManager;
		static public var counts:int = 0;
		public function SimpleSprite()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		protected function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		protected function get assets():AssetManager
		{
			return __assets ? __assets : Content.instance.manager;
		}
		
		protected function onResize(e:Event):void
		{
			//throw new Error("You need override function onResize");
		}
		
		public function setOnCenter():void
		{
			this.x = stage.stageWidth >> 1;
			this.y = stage.stageHeight >> 1;
		}
		
		protected function destroy(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);	
			stage.removeEventListener(Event.RESIZE, onResize);
		}
	}
}