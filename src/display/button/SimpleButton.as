package display.button
{
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import display.TextureSprite;
	
	public class SimpleButton extends TextureSprite
	{
		private var __onTriggered:Function;
		
		//Align
		private var __scale:Number = 1;
		
		public function SimpleButton(texture:Texture, onTriggered:Function)
		{
			__onTriggered = onTriggered;
			super(texture);
		}
		
		override protected function init(e:Event=null):void
		{
			super.init(e);
			alignPivot();
			addEventListener( TouchEvent.TOUCH, onClose);
		}
		
		override public function set scaleX(value:Number):void
		{
			super.scaleX = value;
			__scale = value;
		}
		
		override public function set scaleY(value:Number):void
		{
			super.scaleY = value;
			__scale = value;
		}
		
		protected function onClose(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(e.currentTarget as DisplayObject);
			if (!touches.length) return;
			
			for each (var touch:Touch in touches)
			{
				if(touch.phase == TouchPhase.BEGAN) super.scaleX = super.scaleY = __scale*0.75;
				if(touch.phase == TouchPhase.ENDED)
				{
					super.scaleX = super.scaleY = __scale;
					if(__onTriggered) __onTriggered(e);
				}
			}
		}	
		
		override protected function destroy(e:Event):void
		{
			super.destroy(e);
			removeEventListener( TouchEvent.TOUCH, onClose);
		}
	}
}