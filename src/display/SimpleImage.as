package display
{
	import Assets.Content;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class SimpleImage extends Image
	{
		private var __onInit:Function;
		private var __assets:AssetManager;
		
		//public var onDestroy:Function;
		
		public function SimpleImage(texture:Texture, onInit:Function = null)
		{
			__onInit = onInit;
			super(texture);
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		protected function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			if(__onInit) __onInit();
		}
		
		protected function get assets():AssetManager
		{
			return __assets ? __assets : Content.instance.manager;
		}
		
		protected function destroy(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);	
			this.texture.dispose();
		}
	}
}