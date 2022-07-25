package
{
	import Assets.Content;
	
	import display.managers.ScreenManager;
	import display.managers.WindowsManager;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class appMain extends Sprite
	{
		static public var instance:Sprite;
		static public var loadComplete:Function;
		
		public function appMain()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			instance = this;
			
			Content.instance.addEventListener("onProgress", onProgress);
			Content.instance.addEventListener("onComplete", onComplete);
			
			Content.instance.loadTexture();	
		}
		
		private function onComplete(e:Event):void
		{
			WindowsManager.mainSprite = this;
			ScreenManager.mainSprite = this;
			WindowsManager.addListeners();
			
			if(loadComplete != null) loadComplete.call();
			else throw new Error("appMain.loadComplete function must be initialize")
		}
		
		private function onProgress(e:Event):void
		{
			
		}
		
		private function destroy(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			Content.instance.removeEventListener("onProgress", onProgress);
			Content.instance.removeEventListener("onComplete", onComplete);
		}
	}
}