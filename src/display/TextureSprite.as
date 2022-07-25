package display
{
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;

	public class TextureSprite extends SimpleSprite
	{
		private var __onInit:Function;
		private var __texture:Texture;
		private var __image:Image;
		
		public function TextureSprite(texture:Texture, onInit:Function = null)
		{
			__onInit = onInit;
			__texture = texture;
		}
		
		override protected function init(e:Event = null):void
		{
			super.init(e);
			createImage();
			
			if(__onInit) __onInit();
		}
		
		private function createImage():void
		{
			__image = new Image( __texture );
			this.addChild( __image );
		}
		
		public function set smoothing(val:String):void
		{
			__image.smoothing = val;
		}
		
		override protected function onResize(e:Event):void{}
		
		override protected function destroy(event:Event):void
		{
			super.destroy(event);
			this.__image.texture.dispose();
		}
	}
}