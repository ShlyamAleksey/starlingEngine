package display.scroll
{
	import com.greensock.TweenLite;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import display.SimpleSprite;

	public class SimpleScrollItem extends SimpleSprite
	{
		private var __filter:ColorFilter;
		private var data:Object;
		private var __callback:Function;
		
		private var __startPosition:Number = 0;
		private const __sensivity:Number = 7;
		
		private var __trigger:Boolean = false;
		
		public function SimpleScrollItem(callback:Function = null, data:Object = null)
		{
			this.data = data;
			__callback = callback;
		}
		
		override protected function init(e:Event = null):void
		{
			super.init(e);

			addListeners();
			
			__filter = new ColorFilter();
			this.filter = __filter;
		}
		
		private function addListeners():void
		{
			this.addEventListener( TouchEvent.TOUCH, onTouch);
		}
		
		
		private function onTouch(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(e.currentTarget as DisplayObject);
			
			for each (var touch:Touch in touches)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					__startPosition = touch.getLocation(stage).x;
					tween2dark();
					__trigger = true;
				}

				if(touch.phase == TouchPhase.ENDED)
				{
					tween2normal();
					__startPosition = 0;
					if(__trigger && __callback) __callback(this.data);
				}

				if(touch.phase == TouchPhase.MOVED)
				{
					if( Math.abs(__startPosition - touch.getLocation(stage).x) > __sensivity )
					{
						tween2normal();
						__trigger = false;
					}
				}
			}
		}
		
		private function tween2dark():void
		{
			TweenLite.to( __filter, 0.1, {	rr : 1500, 	rg : 0, 	rb : 0,
											gr : 0, 	gg : 1500, 	gb : 0,
											br : 0, 	bg : 0, 	bb : 1500, update: 1});
		}
		
		private function tween2normal():void
		{
			TweenLite.to( __filter, 0.1, {	rr : 1000, 	rg : 0, 	rb : 0,
											gr : 0, 	gg : 1000, 	gb : 0,
											br : 0, 	bg : 0, 	bb : 1000, update: 1});
		}
		
		override protected function onResize(e:Event):void{}
		
		override protected function destroy(e:Event):void
		{
			super.destroy(e);
			this.removeEventListener( TouchEvent.TOUCH, onTouch);
		}
	}
}