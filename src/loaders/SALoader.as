package loaders 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class SALoader
	{
		
		/**	complete - Dispatched when data has loaded successfully.
			init - Dispatched when the properties and methods of a loaded SWF file are accessible (ex. when only first frame was loaded).*/
		public function SALoader(url:String, fun:Function)
		{
			var req:URLRequest = new URLRequest(url);
			var loader:Loader = new Loader();
			
			var loaderContext:LoaderContext = new LoaderContext(true, ApplicationDomain.currentDomain, null);
			loader.load(req, loaderContext);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			
			function onLoadComplete(e:Event):void
			{
				if(fun) fun( loader );					
				loader.removeEventListener(Event.COMPLETE, onLoadComplete);
			}
		}
	}
}