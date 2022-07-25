package display.scroll
{
	import com.greensock.TweenLite;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import display.SimpleShape;
	import display.SimpleSprite;
	
	public class SimpleTouchScroll extends SimpleSprite
	{
		protected var __scrollMask:SimpleShape;
		protected var __itemsCanvas:SimpleSprite;
		protected var __maskWidth:Number = 900;
		protected var __maskHeight:Number = 260;
		
		//align
		private var __scrollWidth:Number = 0;
		private var __scrollPosition:Number = 0;
		private var _x:Number;
		
		public function SimpleTouchScroll(maskWidth:Number= 500, maskHeight:Number= 300)
		{
			__maskWidth = maskWidth;
			__maskHeight = maskHeight;
		}
		
		override protected function init(e:Event = null):void
		{
			super.init(e);
			
			createMask();
			createItemsCanvas();
			onResize(null);
			
			addListeners();
		}
		
		private function addListeners():void
		{
			__itemsCanvas.addEventListener(TouchEvent.TOUCH, onDrag);
		}
		
		private function removeListeners():void
		{
			__itemsCanvas.removeEventListener(TouchEvent.TOUCH, onDrag);
		}
		
		private function onDrag(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(e.currentTarget as DisplayObject);
			(e.currentTarget as DisplayObject).useHandCursor = true;
			
			for each (var touch:Touch in touches)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					_x = touch.getLocation(__itemsCanvas).x;
				}
				else if(touch.phase == TouchPhase.MOVED)
				{
					__scrollPosition = touch.getLocation(this).x - _x;
					
					if(__scrollPosition > 0 ) __scrollPosition = 0;
					else if(__scrollPosition < (__maskWidth/this.scaleX - __itemsCanvas.width)) __scrollPosition = __maskWidth/this.scaleX - __itemsCanvas.width;
						
					tweeningMove(__scrollPosition  );
				}
			}
		}
		
		private function createItemsCanvas():void
		{
			__itemsCanvas = new SimpleSprite();
			addChild(__itemsCanvas);
		}
		
		private function createMask():void
		{			
			__scrollMask = new SimpleShape(__maskWidth, __maskHeight, 0x0);
			this.addChild( __scrollMask );
			
			this.mask = __scrollMask;
		}
		
		protected function addItem(target:SimpleScrollItem):void
		{
			target.x = __scrollWidth; __itemsCanvas.addChild( target ); 
			
			__scrollWidth = __scrollWidth + target.width + 5;
		}
		
		public function set maskWidth(val:Number):void
		{
			__scrollMask.width = val;
		}
		
		public function set maskHeight(val:Number):void
		{
			__scrollMask.height = val;
		}
		
		public function get maskWidth():Number
		{
			return __scrollMask.width;
		}
		
		public function get maskHeight():Number
		{
			return __scrollMask.height;
		}
		
		private function tweeningMove(pos:Number):void
		{
			TweenLite.to( __itemsCanvas, 1, { x : pos} );
		}
		
		override protected function onResize(e:Event):void{}
		
		override protected function destroy(e:Event):void
		{
			super.destroy(e);
			removeListeners();
		}
	}
}