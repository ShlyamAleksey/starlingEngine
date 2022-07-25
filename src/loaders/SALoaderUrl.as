package loaders 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class SALoaderUrl
	{
		public function SALoaderUrl(url:String, fun:Function, format:String)
		{
			var req:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			
			loader.dataFormat = format;
			
			loader.load(req);
			
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			
			function onLoadComplete(e:Event):void
			{
				if(fun) fun( (e.currentTarget as URLLoader).data );					
				loader.removeEventListener(Event.COMPLETE, onLoadComplete);
			}
		}	
	}
}