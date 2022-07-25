package events
{
	import starling.events.Event;
	
	public class SAEvent extends Event
	{
		public var eventData:Object;
		
		public function SAEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.eventData = data;
			super(type, bubbles, cancelable);
		}
	}
}