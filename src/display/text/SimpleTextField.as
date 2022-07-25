package display.text
{
	import starling.events.Event;
	import starling.text.TextField;
	
	public class SimpleTextField extends TextField
	{
		public function SimpleTextField(width:int, height:int, text:String, fontName:String="Verdana", fontSize:Number=12, color:uint=0x0, bold:Boolean=false)
		{
			super(width, height, text, fontName, fontSize, color, bold);
			
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