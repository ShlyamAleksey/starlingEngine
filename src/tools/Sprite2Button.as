package tools
{
	import com.greensock.TweenLite;
	
	import display.SimpleImage;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Sprite2Button extends Sprite
	{
		static public var SCALE:String = "SCALE";
		static public var COLOR:String = "COLOR";
		
		private var __onTriggered:Function;
		private var __sprite:SimpleImage;

		private var __scale:Number;
		private var __filter:ColorFilter;
		
		public function Sprite2Button(sprite:SimpleImage, onTriggered:Function, type:String = "SCALE"):void
		{
			__sprite = sprite;
			__sprite.useHandCursor = true;
			__onTriggered = onTriggered;
			
			switch(type)
			{
				case SCALE:
					__scale = sprite.scaleX;
					sprite.alignPivot();
					sprite.x += sprite.width >> 1;
					sprite.y += sprite.height >> 1;
					
					sprite.addEventListener( TouchEvent.TOUCH, onTouchScale);		
					break;
					
				case COLOR:
					__filter = new ColorFilter();
					sprite.filter = __filter;
					sprite.addEventListener( TouchEvent.TOUCH, onTouchColor);		
					break;
			}
			
			
		}	
		
		private function onTouchScale(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(e.currentTarget as DisplayObject);
			if (!touches.length) 
			{
				tween2Small();
				return;
			}
			
			for each (var touch:Touch in touches)
			{
				if(touch.phase == TouchPhase.HOVER) tween2Big();
				if(touch.phase == TouchPhase.BEGAN) tween2Small();
				if(touch.phase == TouchPhase.ENDED)
				{
					tween2Small();
					if(__onTriggered) __onTriggered(e);
				}
			}
		}
		
		private function onTouchColor(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(e.currentTarget as DisplayObject);
			if (!touches.length) 
			{
				tween2normal();
				return;
			}
			
			for each (var touch:Touch in touches)
			{
				if(touch.phase == TouchPhase.HOVER) tween2light();
				if(touch.phase == TouchPhase.BEGAN) tween2normal();
				if(touch.phase == TouchPhase.ENDED)
				{
					tween2normal();
					if(__onTriggered) __onTriggered(e);
				}
			}
		}
		
		private function tween2Big():void
		{
			TweenLite.to( __sprite, 0.1, { scaleX : __scale*1.25, scaleY : __scale*1.25	});
		}
		
		private function tween2Small():void
		{
			TweenLite.to( __sprite, 0.1, { scaleX : __scale, scaleY : __scale});
		}
		
		private function tween2light():void
		{
			TweenLite.to( __filter, 0.1, {	rr : 1200, 	rg : 0, 	rb : 0,
											gr : 0, 	gg : 1200, 	gb : 0,
											br : 0, 	bg : 0, 	bb : 1200, update: 1});
		}
		
		private function tween2normal():void
		{
			TweenLite.to( __filter, 0.1, {	rr : 1000, 	rg : 0, 	rb : 0,
				gr : 0, 	gg : 1000, 	gb : 0,
				br : 0, 	bg : 0, 	bb : 1000, update: 1});
		}
	}
}