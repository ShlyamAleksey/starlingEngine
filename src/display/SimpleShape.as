package display
{
	import starling.display.Quad;
	import starling.events.Event;
	
	public class SimpleShape extends Quad
	{
		public function SimpleShape(width:Number = 50, height:Number = 50, color:uint=0xffffff, premultipliedAlpha:Boolean=true)
		{
			super(width, height, color, premultipliedAlpha);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function destroy(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);	
			this.dispose();
		}
	}
}