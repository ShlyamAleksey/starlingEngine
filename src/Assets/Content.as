package Assets
{
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	
	import events.ContentEvent;
	
	import loaders.SALoaderUrl;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	public class Content extends EventDispatcher
	{
		static private var __init:Content
		
		private var currentName:String = "";
		static public var atfList:Array;
		static public var IS_NEW:Boolean = false;
		
		private var currentXML:XML;
		private var currentATF:Texture;

		public var manager:AssetManager = new AssetManager();
		
		static public function get instance():Content
		{
			if(!__init) __init = new Content();
			return __init;
		}
			
		public function loadTexture():void
		{
			if(atfList.length == 0)
			{
				loadSounds();		
				return;
			}
			currentName = atfList[0];
			atfList.shift();
			
			if(IS_NEW)  var cache:int = Math.random()*int.MAX_VALUE;
			
			new SALoaderUrl(Connections.STATIC_PATH + currentName + ".xml?" + cache, onXML, URLLoaderDataFormat.TEXT);
			dispatchEvent( new Event( ContentEvent.ON_PROGRESS ));
		}
		
		private function loadSounds():void
		{
			SASoundManager.loadSounds();
			dispatchEvent( new Event( ContentEvent.ON_COMPLETE ));
		}
		
		private function onXML(data:String):void
		{			
			dispatchEvent( new Event( ContentEvent.ON_PROGRESS ));
			currentXML = XML(data);
			
			if(IS_NEW)  var cache:int = Math.random()*int.MAX_VALUE;
			new SALoaderUrl(Connections.STATIC_PATH + currentName + ".atf?" + cache, onATF, URLLoaderDataFormat.BINARY);
		}

		private function onATF(data:Object):void
		{
			currentATF = Texture.fromAtfData(data as ByteArray);
			var atlas:TextureAtlas = new TextureAtlas(currentATF, currentXML);	
			manager.addTextureAtlas(currentName, atlas);

			loadTexture();
		}
	}
}